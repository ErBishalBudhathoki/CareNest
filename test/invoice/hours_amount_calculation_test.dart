import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Hours × Rate total amount calculation', () {
    test('calculates total for precise hours including seconds', () {
      const hours = 1.0036; // includes ~13 seconds
      const rate = 50.0;
      final amount = double.parse((hours * rate).toStringAsFixed(2));
      expect(amount, 50.18);
    });

    test('calculates total for quarter hours', () {
      const hours = 2.25;
      const rate = 40.0;
      final amount = double.parse((hours * rate).toStringAsFixed(2));
      expect(amount, 90.00);
    });

    test('handles zero hours', () {
      const hours = 0.0;
      const rate = 60.0;
      final amount = double.parse((hours * rate).toStringAsFixed(2));
      expect(amount, 0.00);
    });
  });
}