import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:ui_playground_llm/models/ui_property.dart';

class GeminiService {
  late final GenerativeModel _model;
  final List<Content> _conversationHistory = [];

  GeminiService() {
    log('Initializing GeminiService');
    final apiKey = dotenv.env['GEMMNI_KEY'];
    if (apiKey == null || apiKey.isEmpty) {
      log('GEMMNI_KEY not found in environment variables');
      throw Exception('GEMMNI_KEY not found in environment variables');
    }

    _model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: apiKey,
    );
    log('GeminiService initialization completed');
  }

  Future<UIProperty?> processUICommand({
    required String userCommand,
    required UIProperty currentProperties,
  }) async {
    try {
      // Create the system prompt with current state
      final systemPrompt = _buildSystemPrompt(currentProperties);

      // Add system context to conversation if it's the first message or reset
      if (_conversationHistory.isEmpty) {
        _conversationHistory.add(Content.text(systemPrompt));
      }

      // Add user command to conversation
      _conversationHistory.add(Content.text(userCommand));

      log('Sending request to Gemini with command: $userCommand');

      // Generate response
      final response = await _model.generateContent(_conversationHistory);

      if (response.text == null || response.text!.isEmpty) {
        throw Exception('Empty response from Gemini');
      }

      log('Received response from Gemini: ${response.text}');

      // Add AI response to conversation history
      _conversationHistory.add(Content.text(response.text!));

      // Parse JSON response
      final UIProperty updatedProperties =
          _parseGeminiResponse(response.text!, currentProperties);

      return updatedProperties;
    } catch (e) {
      log('Error in processUICommand: $e');
      // Remove the last user message from history if there was an error
      if (_conversationHistory.isNotEmpty) {
        _conversationHistory.removeLast();
      }
      rethrow;
    }
  }

  String _buildSystemPrompt(UIProperty currentProperties) {
    return '''
You are a UI assistant that helps users modify Flutter UI properties through natural language commands. 
You MUST respond ONLY with valid JSON, nothing else - no explanations, no markdown, just pure JSON.

Current UI Properties:
${currentProperties.toJsonString()}

The user can request changes to any of these properties:
- backgroundColor: hex color string (e.g., "#FF1A1B1E")
- title: string for the screen title
- textFieldWidth: number for text field width in pixels
- textFieldHeight: number for text field height in pixels  
- saveButtonTitle: string for save button text
- saveButtonWidth: number for save button width in pixels
- saveButtonHeight: number for save button height in pixels
- saveButtonBackgroundColor: hex color string (e.g., "#FF9600FF")

Rules for processing commands:
1. If user says "increase" or "bigger" without specific values, increase by 20% for sizes or use brighter colors
2. If user says "decrease" or "smaller" without specific values, decrease by 20% for sizes or use darker colors
3. For color changes, accept common color names (red, blue, green, etc.) and convert to hex
4. Keep values within reasonable ranges: 
   - Width/Height: minimum 50px, maximum 800px
   - Colors: valid hex format with alpha channel
5. If a property isn't mentioned in the command, keep its current value
6. Always return complete JSON with all properties

Respond ONLY with JSON in this exact format:
{
  "backgroundColor": "#FF1A1B1E",
  "title": "Custom Form",
  "textFieldWidth": 300.0,
  "textFieldHeight": 56.0,
  "saveButtonTitle": "Save",
  "saveButtonWidth": 150.0,
  "saveButtonHeight": 45.0,
  "saveButtonBackgroundColor": "#FF9600FF"
}''';
  }

  UIProperty _parseGeminiResponse(
      String responseText, UIProperty fallbackProperties) {
    try {
      // Clean the response text - remove any markdown code blocks or extra text
      String cleanedResponse = responseText.trim();

      // Remove markdown code blocks if present
      if (cleanedResponse.startsWith('```json')) {
        cleanedResponse = cleanedResponse.substring(7);
      }
      if (cleanedResponse.startsWith('```')) {
        cleanedResponse = cleanedResponse.substring(3);
      }
      if (cleanedResponse.endsWith('```')) {
        cleanedResponse =
            cleanedResponse.substring(0, cleanedResponse.length - 3);
      }

      cleanedResponse = cleanedResponse.trim();

      log('Parsing cleaned response: $cleanedResponse');

      // Parse JSON
      final Map<String, dynamic> jsonData = jsonDecode(cleanedResponse);

      // Validate and create UIProperty
      return UIProperty.fromJson(jsonData);
    } catch (e) {
      log('Error parsing Gemini response: $e');
      log('Response text was: $responseText');
      throw Exception('Failed to parse AI response: $e');
    }
  }

  // Reset conversation history
  void resetConversation() {
    _conversationHistory.clear();
    log('Conversation history reset');
  }

  // Get conversation history for debugging
  List<String> getConversationHistory() {
    return _conversationHistory.map((content) {
      final part = content.parts.first;
      if (part is TextPart) {
        return part.text;
      }
      return 'Non-text content';
    }).toList();
  }

  // Default UI properties
  static UIProperty getDefaultProperties() {
    return UIProperty(
      backgroundColor: '#FF1A1B1E',
      title: 'Custom Form',
      textFieldWidth: 300.0,
      textFieldHeight: 56.0,
      saveButtonTitle: 'Save',
      saveButtonWidth: 150.0,
      saveButtonHeight: 45.0,
      saveButtonBackgroundColor: '#FF9600FF',
    );
  }
}
