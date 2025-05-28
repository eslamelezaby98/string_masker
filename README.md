# String Masker

A Flutter package for masking and validating sensitive data like emails, phone numbers, and credit cards.

## Features

- 🔒 Mask sensitive data (emails, phone numbers, credit cards)
- ✅ Built-in validation for common formats
- 🎯 Custom masking patterns
- 🛡️ Input validation before masking
- 🎨 Customizable mask characters

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  string_masker: ^1.0.0
```

## Usage

### Basic Usage

```dart
import 'package:string_masker/string_masker.dart';

// Mask an email
String? maskedEmail = StringMasker.mask(
  'john.doe@example.com',
  type: MaskType.email,
); // Returns: "j******@e******.com"

// Mask a phone number
String? maskedPhone = StringMasker.mask(
  '+1 (555) 123-4567',
  type: MaskType.phone,
); // Returns: "+1 (5*****3-67"

// Mask a credit card
String? maskedCard = StringMasker.mask(
  '4532715337901241',
  type: MaskType.card,
); // Returns: "**** **** **** 1241"

// Custom masking
String? maskedCustom = StringMasker.mask(
  'Hello World',
  type: MaskType.custom,
  start: 2,
  end: 3,
  maskChar: '#',
); // Returns: "He###World"
```

### Validation

The package includes built-in validators for common data types:

```dart
// Email validation
bool isValidEmail = StringValidator.isValidEmail('john.doe@example.com');

// Phone validation
bool isValidPhone = StringValidator.isValidPhone('+1 (555) 123-4567');

// Credit card validation (uses Luhn algorithm)
bool isValidCard = StringValidator.isValidCard('4532715337901241');

// Password validation
bool isValidPassword = StringValidator.isValidPassword(
  'MyPass123!',
  minLength: 8,
  requireUppercase: true,
  requireLowercase: true,
  requireNumbers: true,
  requireSpecialChars: true,
);
```

### Masking with Validation

The `mask` method automatically validates input before masking:

```dart
String? result = StringMasker.mask(
  'invalid.email',
  type: MaskType.email,
); // Returns: null (invalid email)

if (result == null) {
  print('Invalid input - masking failed');
} else {
  print('Masked result: $result');
}
```

## Available Mask Types

- `MaskType.email` - Masks email addresses while preserving format
- `MaskType.phone` - Masks phone numbers while keeping prefix/suffix
- `MaskType.card` - Masks credit card numbers (shows last 4 digits)
- `MaskType.custom` - Custom masking with configurable start/end positions

## Validation Features

### Email Validation
- Proper email format (username@domain.tld)
- Case-insensitive
- Common TLD support

### Phone Validation
- International format support
- Optional '+' prefix
- 8-15 digits length
- Flexible formatting

### Credit Card Validation
- Luhn algorithm implementation
- 13-19 digits length
- Removes non-digit characters
- Major card types support

### Password Validation
- Minimum length check
- Uppercase letters requirement
- Lowercase letters requirement
- Numbers requirement
- Special characters requirement
- Customizable requirements

## Example

Check out the [example](example) directory for a complete sample application demonstrating all features.

## Additional Information

### Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
