class StringValidator {
  /// Validates an email address.
  /// Returns true if the email is valid, false otherwise.
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
      caseSensitive: false,
    );
    return emailRegex.hasMatch(email);
  }

  /// Validates a credit card number using the Luhn algorithm.
  /// Returns true if the card number is valid, false otherwise.
  static bool isValidCard(String card) {
    // Remove any non-digit characters
    final digits = card.replaceAll(RegExp(r'\D'), '');

    if (digits.isEmpty || digits.length < 13 || digits.length > 19) {
      return false;
    }

    // Luhn algorithm implementation
    int sum = 0;
    bool alternate = false;

    // Loop through values starting from the rightmost digit
    for (int i = digits.length - 1; i >= 0; i--) {
      int n = int.parse(digits[i]);

      if (alternate) {
        n *= 2;
        if (n > 9) {
          n = (n % 10) + 1;
        }
      }

      sum += n;
      alternate = !alternate;
    }

    return sum % 10 == 0;
  }

  /// Validates a phone number.
  /// Returns true if the phone number is valid, false otherwise.
  static bool isValidPhone(String phone) {
    // Remove any non-digit characters except + (for international numbers)
    final cleanPhone = phone.replaceAll(RegExp(r'[^\d+]'), '');

    // Basic phone number validation
    // Allows:
    // - Optional + prefix
    // - 8 to 15 digits
    final phoneRegex = RegExp(r'^\+?\d{8,15}$');
    return phoneRegex.hasMatch(cleanPhone);
  }

  /// Validates a date string in the format YYYY-MM-DD.
  /// Returns true if the date is valid, false otherwise.
  static bool isValidDate(String date) {
    try {
      final parts = date.split('-');
      if (parts.length != 3) return false;

      final year = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final day = int.parse(parts[2]);

      final dateTime = DateTime(year, month, day);
      return dateTime.year == year &&
          dateTime.month == month &&
          dateTime.day == day;
    } catch (e) {
      return false;
    }
  }

  /// Validates a password based on common security requirements.
  /// Returns true if the password meets the requirements, false otherwise.
  static bool isValidPassword(
    String password, {
    int minLength = 8,
    bool requireUppercase = true,
    bool requireLowercase = true,
    bool requireNumbers = true,
    bool requireSpecialChars = true,
  }) {
    if (password.length < minLength) return false;

    if (requireUppercase && !password.contains(RegExp(r'[A-Z]'))) return false;
    if (requireLowercase && !password.contains(RegExp(r'[a-z]'))) return false;
    if (requireNumbers && !password.contains(RegExp(r'[0-9]'))) return false;
    if (requireSpecialChars &&
        !password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return false;
    }

    return true;
  }
}
