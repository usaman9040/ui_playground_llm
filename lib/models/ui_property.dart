import 'dart:convert';
import 'dart:ui';

class UIProperty {
  final String backgroundColor;
  final String title;
  final double textFieldWidth;
  final double textFieldHeight;
  final String saveButtonTitle;
  final double saveButtonWidth;
  final double saveButtonHeight;
  final String saveButtonBackgroundColor;

  UIProperty({
    required this.backgroundColor,
    required this.title,
    required this.textFieldWidth,
    required this.textFieldHeight,
    required this.saveButtonTitle,
    required this.saveButtonWidth,
    required this.saveButtonHeight,
    required this.saveButtonBackgroundColor,
  });

  // Factory constructor to create UIProperty from current values
  factory UIProperty.fromCurrentValues({
    required Color backgroundColor,
    required String title,
    required double textFieldWidth,
    required double textFieldHeight,
    required String saveButtonTitle,
    required double saveButtonWidth,
    required double saveButtonHeight,
    required Color saveButtonBackgroundColor,
  }) {
    return UIProperty(
      backgroundColor: '#${backgroundColor.toARGB32().toRadixString(16).padLeft(8, '0')}',
      title: title,
      textFieldWidth: textFieldWidth,
      textFieldHeight: textFieldHeight,
      saveButtonTitle: saveButtonTitle,
      saveButtonWidth: saveButtonWidth,
      saveButtonHeight: saveButtonHeight,
      saveButtonBackgroundColor: '#${saveButtonBackgroundColor.toARGB32().toRadixString(16).padLeft(8, '0')}',
    );
  }

  // Factory constructor from JSON
  factory UIProperty.fromJson(Map<String, dynamic> json) {
    return UIProperty(
      backgroundColor: json['backgroundColor'] ?? '#FF1A1B1E',
      title: json['title'] ?? 'Custom Form',
      textFieldWidth: (json['textFieldWidth'] ?? 300.0).toDouble(),
      textFieldHeight: (json['textFieldHeight'] ?? 56.0).toDouble(),
      saveButtonTitle: json['saveButtonTitle'] ?? 'Save',
      saveButtonWidth: (json['saveButtonWidth'] ?? 150.0).toDouble(),
      saveButtonHeight: (json['saveButtonHeight'] ?? 45.0).toDouble(),
      saveButtonBackgroundColor: json['saveButtonBackgroundColor'] ?? '#FF9600FF',
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'backgroundColor': backgroundColor,
      'title': title,
      'textFieldWidth': textFieldWidth,
      'textFieldHeight': textFieldHeight,
      'saveButtonTitle': saveButtonTitle,
      'saveButtonWidth': saveButtonWidth,
      'saveButtonHeight': saveButtonHeight,
      'saveButtonBackgroundColor': saveButtonBackgroundColor,
    };
  }

  // Helper methods to convert hex colors to Color objects
  Color get backgroundColorValue {
    return Color(int.parse(backgroundColor.substring(1), radix: 16));
  }

  Color get saveButtonBackgroundColorValue {
    return Color(int.parse(saveButtonBackgroundColor.substring(1), radix: 16));
  }

  // Create a copy with updated values
  UIProperty copyWith({
    String? backgroundColor,
    String? title,
    double? textFieldWidth,
    double? textFieldHeight,
    String? saveButtonTitle,
    double? saveButtonWidth,
    double? saveButtonHeight,
    String? saveButtonBackgroundColor,
  }) {
    return UIProperty(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      title: title ?? this.title,
      textFieldWidth: textFieldWidth ?? this.textFieldWidth,
      textFieldHeight: textFieldHeight ?? this.textFieldHeight,
      saveButtonTitle: saveButtonTitle ?? this.saveButtonTitle,
      saveButtonWidth: saveButtonWidth ?? this.saveButtonWidth,
      saveButtonHeight: saveButtonHeight ?? this.saveButtonHeight,
      saveButtonBackgroundColor: saveButtonBackgroundColor ?? this.saveButtonBackgroundColor,
    );
  }

  // Convert JSON string to UIProperty
  static UIProperty fromJsonString(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);
    return UIProperty.fromJson(json);
  }

  // Convert UIProperty to JSON string
  String toJsonString() {
    return jsonEncode(toJson());
  }

  @override
  String toString() {
    return 'UIProperty(backgroundColor: $backgroundColor, title: $title, textFieldSize: ${textFieldWidth}x$textFieldHeight, saveButton: $saveButtonTitle (${saveButtonWidth}x$saveButtonHeight), saveButtonColor: $saveButtonBackgroundColor)';
  }
}
