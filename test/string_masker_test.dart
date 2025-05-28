import 'package:flutter_test/flutter_test.dart';
import 'package:string_masker/string_masker.dart';

void main() {
  test('Email masking', () {
    expect(
      StringMasker.mask('john.doe@gmail.com', type: MaskType.email),
      'j*******@g****.com',
    );
  });

  test('Card masking', () {
    expect(
      StringMasker.mask('1234 5678 9012 3456', type: MaskType.card),
      '**** **** **** 3456',
    );
  });

  test('Phone masking', () {
    expect(
      StringMasker.mask('+971501234567', type: MaskType.phone),
      '+9715******67',
    );
  });

  test('Custom masking', () {
    expect(
      StringMasker.mask('HELLOWORLD', type: MaskType.custom, start: 2, end: 2),
      'HE******LD',
    );
  });
}
