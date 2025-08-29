import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:ui_playground_llm/app/app.locator.dart';
import 'package:ui_playground_llm/models/ui_property.dart';
import 'package:ui_playground_llm/services/gemini_service.dart';

class CustomFormViewModel extends BaseViewModel {
  final _geminiService = locator<GeminiService>();
  
  // Form controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController commandController = TextEditingController();

  // UI Properties - now managed through UIProperty model
  late UIProperty _currentProperties;

  // Form data
  String _name = '';
  String _email = '';
  String _lastCommand = '';
  String _commandResult = '';
  bool _isProcessingCommand = false;
  String? _lastError;

  CustomFormViewModel() {
    _currentProperties = GeminiService.getDefaultProperties();
  }

  // Getters for UI properties
  Color get backgroundColor => _currentProperties.backgroundColorValue;
  String get title => _currentProperties.title;
  double get textFieldWidth => _currentProperties.textFieldWidth;
  double get textFieldHeight => _currentProperties.textFieldHeight;
  String get saveButtonTitle => _currentProperties.saveButtonTitle;
  double get saveButtonWidth => _currentProperties.saveButtonWidth;
  double get saveButtonHeight => _currentProperties.saveButtonHeight;
  Color get saveButtonBackgroundColor => _currentProperties.saveButtonBackgroundColorValue;

  // Getters for form data and state
  String get name => _name;
  String get email => _email;
  String get lastCommand => _lastCommand;
  String get commandResult => _commandResult;
  bool get isProcessingCommand => _isProcessingCommand;
  String? get lastError => _lastError;
  UIProperty get currentProperties => _currentProperties;

  // Apply UI properties from UIProperty model
  void _applyUIProperties(UIProperty properties) {
    _currentProperties = properties;
    _lastError = null;
    rebuildUi();
  }

  // Reset to default properties
  void resetToDefaults() {
    _currentProperties = GeminiService.getDefaultProperties();
    _geminiService.resetConversation();
    _lastError = null;
    _commandResult = 'UI reset to default values.';
    rebuildUi();
  }

  // Form handling methods
  void onNameChanged(String value) {
    _name = value;
    notifyListeners();
  }

  void onEmailChanged(String value) {
    _email = value;
    notifyListeners();
  }

  void onCommandChanged(String value) {
    _lastCommand = value;
    notifyListeners();
  }

  // Save form data
  void saveForm() {
    if (_name.isEmpty || _email.isEmpty) {
      _commandResult = 'Error: Please fill in both name and email fields.';
      rebuildUi();
      return;
    }

    // Simulate saving data
    _commandResult = 'Form saved successfully!\nName: $_name\nEmail: $_email';
    rebuildUi();
    
    // Clear form after successful save
    nameController.clear();
    emailController.clear();
    _name = '';
    _email = '';
  }

  // Execute AI command to modify UI
  Future<void> executeCommand() async {
    if (_lastCommand.isEmpty) {
      _commandResult = 'Error: Please enter a command.';
      _lastError = 'Empty command';
      rebuildUi();
      return;
    }

    _isProcessingCommand = true;
    _lastError = null;
    _commandResult = 'Processing command: "$_lastCommand"...';
    rebuildUi();

    try {
      final updatedProperties = await _geminiService.processUICommand(
        userCommand: _lastCommand,
        currentProperties: _currentProperties,
      );

      if (updatedProperties != null) {
        _applyUIProperties(updatedProperties);
        _commandResult = 'Command executed successfully!\n\nApplied changes: $_lastCommand';
      } else {
        _commandResult = 'No changes were made.';
      }
    } catch (e) {
      _lastError = e.toString();
      _commandResult = 'Error processing command: ${e.toString()}';
    } finally {
      _isProcessingCommand = false;
      // Clear command field after processing
      commandController.clear();
      _lastCommand = '';
      rebuildUi();
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    commandController.dispose();
    super.dispose();
  }
}
