import 'mask_type.dart';
import 'validator.dart';

class StringMasker {
  /// Masks the input string based on the specified type.
  /// Returns null if the input is invalid according to its type.
  static String? mask(
    String input, {
    required MaskType type,
    String maskChar = '*',
    int start = 0,
    int end = 0,
  }) {
    // Validate input based on type before masking
    bool isValid = _validateInput(input, type);
    if (!isValid) return null;

    switch (type) {
      case MaskType.email:
        return _maskEmail(input, maskChar);
      case MaskType.phone:
        return _maskPhone(input, maskChar);
      case MaskType.card:
        return _maskCard(input, maskChar);
      case MaskType.custom:
        return _maskCustom(input, start, end, maskChar);
    }
  }

  /// Validates the input string based on its type
  static bool _validateInput(String input, MaskType type) {
    switch (type) {
      case MaskType.email:
        return StringValidator.isValidEmail(input);
      case MaskType.phone:
        return StringValidator.isValidPhone(input);
      case MaskType.card:
        return StringValidator.isValidCard(input);
      case MaskType.custom:
        return input.isNotEmpty; // Custom type only requires non-empty input
    }
  }

  static String _maskEmail(String email, String maskChar) {
    final parts = email.split('@');
    if (parts.length != 2) return email;
    final name = parts[0];
    final domain = parts[1];
    final maskedName =
        name.length <= 1 ? maskChar : name[0] + maskChar * (name.length - 1);
    final domainParts = domain.split('.');
    final domainMasked = domainParts[0].length <= 1
        ? maskChar
        : domainParts[0][0] + maskChar * (domainParts[0].length - 1);
    return '$maskedName@${domainMasked}.${domainParts.sublist(1).join('.')}';
  }

  static String _maskPhone(String phone, String maskChar) {
    const unmaskedStart = 5;
    const unmaskedEnd = 2;
    final maskedLength = phone.length - unmaskedStart - unmaskedEnd;
    if (maskedLength <= 0) return phone;
    return phone.substring(0, unmaskedStart) +
        maskChar * maskedLength +
        phone.substring(phone.length - unmaskedEnd);
  }

  static String _maskCard(String card, String maskChar) {
    final digits = card.replaceAll(RegExp(r'\D'), '');
    final visibleDigits = 4;
    final masked = List.generate(digits.length, (i) {
      if (i < digits.length - visibleDigits) return maskChar;
      return digits[i];
    });
    return masked
        .join()
        .replaceAllMapped(RegExp(r".{4}"), (match) => "${match.group(0)} ")
        .trim();
  }

  static String _maskCustom(String input, int start, int end, String maskChar) {
    if (input.length <= start + end) return input;
    return input.substring(0, start) +
        maskChar * (input.length - start - end) +
        input.substring(input.length - end);
  }
}
