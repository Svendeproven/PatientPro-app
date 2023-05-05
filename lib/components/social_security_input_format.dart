import 'package:flutter/services.dart';

/// Input format for social security numbers to ensure format XXXXXX-XXXX
class SocialSecurityInputFormat extends TextInputFormatter {
  static const int _maxChars = 11;

  /// override formatEditUpdate to ensure the correct format
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final StringBuffer newText = StringBuffer();
    final int newLength = newValue.text.length;

    for (int i = 0; i < newLength; i++) {
      final String character = newValue.text[i];

      // Add a dash after the first 6 characters
      if (i == 6) {
        newText.write('-');
      }

      // Only add numbers
      if (i < _maxChars && RegExp(r'[0-9]').hasMatch(character)) {
        newText.write(character);
      }
    }

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
