import 'package:craftsiliconweather/core/common/utils/app_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('StringExtension.capitalizeFirstLetter', () {
    test('capitalizes the first letter of a non-empty string', () {
      expect("hello".capitalizeFirstLetter(), "Hello");
      expect("flutter".capitalizeFirstLetter(), "Flutter");
      expect("test".capitalizeFirstLetter(), "Test");
    });

    test('returns the same string if already capitalized', () {
      expect("Hello".capitalizeFirstLetter(), "Hello");
      expect("Flutter".capitalizeFirstLetter(), "Flutter");
    });

    test('handles empty strings correctly', () {
      expect("".capitalizeFirstLetter(), "");
    });

    test('handles single-character strings correctly', () {
      expect("a".capitalizeFirstLetter(), "A");
      expect("A".capitalizeFirstLetter(), "A");
    });

    test('does not modify strings starting with non-alphabetic characters', () {
      expect("123abc".capitalizeFirstLetter(), "123abc");
      expect("@flutter".capitalizeFirstLetter(), "@flutter");
      expect(" flutter".capitalizeFirstLetter(), " flutter");
    });
  });
}