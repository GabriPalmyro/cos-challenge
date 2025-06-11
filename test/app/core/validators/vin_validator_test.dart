import 'package:cos_challenge/app/core/validators/vin_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('VinValidator Test | ', () {
    group('validate() | ', () {
      test('should return null for valid VIN numbers', () {
        // Valid VIN formats (17 characters, no I, O, Q)
        expect(VinValidator.validate('1HGBH41JXMN109186'), isNull);
        expect(VinValidator.validate('JH4KA7550PC008269'), isNull);
        expect(VinValidator.validate('WBAVU37598NT13223'), isNull);
        expect(VinValidator.validate('1FTFW1EF5DFC12345'), isNull);
        expect(VinValidator.validate('4T1BF1FK5CU123456'), isNull);
        expect(VinValidator.validate('JTEBU5JR5C5123456'), isNull);
        expect(VinValidator.validate('5NPF34AF5HH123456'), isNull);
        expect(VinValidator.validate('1N4AL3AP8FC123456'), isNull);
        expect(VinValidator.validate('3VW267AJ9EM123456'), isNull);
        expect(VinValidator.validate('KMHDN4AE3CU123456'), isNull);
      });

      test('should return error message for null input', () {
        expect(VinValidator.validate(null), equals('VIN cannot be empty'));
      });

      test('should return error message for empty input', () {
        expect(VinValidator.validate(''), equals('VIN cannot be empty'));
      });

      test('should return error message for incorrect length', () {
        // Too short
        expect(VinValidator.validate('1HGBH41JX'), equals('VIN must be exactly 17 characters long'));
        expect(VinValidator.validate('123456789012345'), equals('VIN must be exactly 17 characters long'));
        expect(VinValidator.validate('A'), equals('VIN must be exactly 17 characters long'));
        
        // Too long
        expect(VinValidator.validate('1HGBH41JXMN109186X'), equals('VIN must be exactly 17 characters long'));
        expect(VinValidator.validate('1HGBH41JXMN109186XX'), equals('VIN must be exactly 17 characters long'));
        expect(VinValidator.validate('123456789012345678'), equals('VIN must be exactly 17 characters long'));
      });

      test('should return error message for invalid characters I, O, Q', () {
        // Contains I
        expect(VinValidator.validate('IHGBH41JXMN109186'), equals('VIN cannot contain I, O, or Q characters'));
        expect(VinValidator.validate('1HGBH41IXMN109186'), equals('VIN cannot contain I, O, or Q characters'));
        expect(VinValidator.validate('1HGBH41JXMN10918I'), equals('VIN cannot contain I, O, or Q characters'));
        
        // Contains O
        expect(VinValidator.validate('OHGBH41JXMN109186'), equals('VIN cannot contain I, O, or Q characters'));
        expect(VinValidator.validate('1HGBH41OXMN109186'), equals('VIN cannot contain I, O, or Q characters'));
        expect(VinValidator.validate('1HGBH41JXMN10918O'), equals('VIN cannot contain I, O, or Q characters'));
        
        // Contains Q
        expect(VinValidator.validate('QHGBH41JXMN109186'), equals('VIN cannot contain I, O, or Q characters'));
        expect(VinValidator.validate('1HGBH41QXMN109186'), equals('VIN cannot contain I, O, or Q characters'));
        expect(VinValidator.validate('1HGBH41JXMN10918Q'), equals('VIN cannot contain I, O, or Q characters'));
        
        // Contains multiple invalid characters
        expect(VinValidator.validate('IHGBH41OXMN10918Q'), equals('VIN cannot contain I, O, or Q characters'));
      });

      test('should return error message for other invalid characters', () {
        // Contains lowercase - these are actually accepted due to .toUpperCase() conversion
        expect(VinValidator.validate('1hgbh41jxmn109186'), isNull);
        expect(VinValidator.validate('1HGBH41jXMN109186'), isNull);
        
        // Contains special characters
        expect(VinValidator.validate('1HGBH41-XMN109186'), equals('VIN contains invalid characters'));
        expect(VinValidator.validate('1HGBH41.XMN109186'), equals('VIN contains invalid characters'));
        expect(VinValidator.validate('1HGBH41@XMN109186'), equals('VIN contains invalid characters'));
        expect(VinValidator.validate('1HGBH41#XMN109186'), equals('VIN contains invalid characters'));
        expect(VinValidator.validate('1HGBH41 XMN109186'), equals('VIN contains invalid characters'));
        expect(VinValidator.validate('1HGBH41_XMN109186'), equals('VIN contains invalid characters'));
        expect(VinValidator.validate('1HGBH41+XMN109186'), equals('VIN contains invalid characters'));
        expect(VinValidator.validate('1HGBH41=XMN109186'), equals('VIN contains invalid characters'));
      });

      test('should handle edge cases', () {
        // All numbers (17 characters - valid)
        expect(VinValidator.validate('12345678901234567'), isNull);
        expect(VinValidator.validate('1234567890123456'), equals('VIN must be exactly 17 characters long')); // 16 chars
        
        // All valid letters (no I, O, Q)
        expect(VinValidator.validate('ABCDEFGHJKLMNPRST'), isNull);
        expect(VinValidator.validate('UVWXYZABCDEFGHJKL'), isNull);
        
        // Mix of valid characters
        expect(VinValidator.validate('1A2B3C4D5E6F7G8H9'), isNull);
        expect(VinValidator.validate('Z9Y8X7W6V5T4S3R2P'), isNull);
        
        // Whitespace handling
        expect(VinValidator.validate('   '), equals('VIN must be exactly 17 characters long'));
        expect(VinValidator.validate('1HGBH41JXMN109186 '), equals('VIN must be exactly 17 characters long'));
        expect(VinValidator.validate(' 1HGBH41JXMN109186'), equals('VIN must be exactly 17 characters long'));
      });

      test('should prioritize length validation over character validation', () {
        // Short VIN with invalid characters should return length error first
        expect(VinValidator.validate('123I'), equals('VIN must be exactly 17 characters long'));
        expect(VinValidator.validate('ABCO'), equals('VIN must be exactly 17 characters long'));
        expect(VinValidator.validate('XYQ'), equals('VIN must be exactly 17 characters long'));
        
        // Long VIN with invalid characters should return length error first
        expect(VinValidator.validate('1HGBH41JXMN109186EXTRA'), equals('VIN must be exactly 17 characters long'));
      });

      test('should validate real-world VIN examples', () {
        // Real manufacturer VIN patterns (anonymized)
        expect(VinValidator.validate('JH4CC2569NC123456'), isNull); // Honda-like
        expect(VinValidator.validate('1FTFW1ET5EF123456'), isNull); // Ford-like
        expect(VinValidator.validate('4T1BF1FK9EU123456'), isNull); // Toyota-like
        expect(VinValidator.validate('WBAVA3754VB123456'), isNull); // BMW-like
        expect(VinValidator.validate('WDDGF8AB4EA123456'), isNull); // Mercedes-like
        expect(VinValidator.validate('ZFFXA19B6N1234567'), isNull); // Ferrari-like
        expect(VinValidator.validate('WP1AA2A2XBL123456'), isNull); // Porsche-like
      });

      test('should accept lowercase characters due to toUpperCase() conversion', () {
        // Mixed case should be accepted
        expect(VinValidator.validate('1hgbh41jxmn109186'), isNull);
        expect(VinValidator.validate('jh4cc2569nc123456'), isNull);
        expect(VinValidator.validate('WBAvU37598nt13223'), isNull);
        expect(VinValidator.validate('1FTFW1et5eF123456'), isNull);
      });
    });

    group('VinRegEx Test | ', () {
      test('should match valid VIN patterns', () {
        expect(VinRegEx.vinFormat.hasMatch('1HGBH41JXMN109186'), isTrue);
        expect(VinRegEx.vinFormat.hasMatch('JH4KA7550PC008269'), isTrue);
        expect(VinRegEx.vinFormat.hasMatch('WBAVU37598NT13223'), isTrue);
        expect(VinRegEx.vinFormat.hasMatch('ABCDEFGHJKLMNPRST'), isTrue);
        expect(VinRegEx.vinFormat.hasMatch('1234567891234567B'), isTrue); // 17 chars, valid pattern
      });

      test('should correctly identify invalid characters', () {
        expect(VinRegEx.invalidChars.hasMatch('I'), isTrue);
        expect(VinRegEx.invalidChars.hasMatch('O'), isTrue);
        expect(VinRegEx.invalidChars.hasMatch('Q'), isTrue);
        expect(VinRegEx.invalidChars.hasMatch('ABCDEFGHJKLMNPRST'), isFalse);
        expect(VinRegEx.invalidChars.hasMatch('1234567890'), isFalse);
        expect(VinRegEx.invalidChars.hasMatch('UVWXYZ'), isFalse);
      });

      test('should not match invalid VIN patterns', () {
        expect(VinRegEx.vinFormat.hasMatch('invalid-vin'), isFalse);
        expect(VinRegEx.vinFormat.hasMatch('1hgbh41jxmn109186'), isFalse); // lowercase (regex is case sensitive)
        expect(VinRegEx.vinFormat.hasMatch('1HGBH41-XMN109186'), isFalse); // hyphen
        expect(VinRegEx.vinFormat.hasMatch('1HGBH41 XMN109186'), isFalse); // space
        expect(VinRegEx.vinFormat.hasMatch('1HGBH41.XMN109186'), isFalse); // dot
        expect(VinRegEx.vinFormat.hasMatch(''), isFalse); // empty
        expect(VinRegEx.vinFormat.hasMatch('123'), isFalse); // too short
        expect(VinRegEx.vinFormat.hasMatch('1HGBH41JXMN109186XX'), isFalse); // too long
      });

      test('should handle mixed case and edge cases in regex', () {
        // Test that regex is case sensitive (expects uppercase)
        expect(VinRegEx.vinFormat.hasMatch('1HGBH41JXMN109186'), isTrue);
        expect(VinRegEx.vinFormat.hasMatch('1hgbh41jxmn109186'), isFalse);
        expect(VinRegEx.vinFormat.hasMatch('1HgBh41JxMn109186'), isFalse);
        
        // Test boundaries
        expect(VinRegEx.vinFormat.hasMatch('A1HGBH41JXMN109186'), isFalse); // 18 chars
        expect(VinRegEx.vinFormat.hasMatch('1HGBH41JXMN10918'), isFalse); // 16 chars
      });
    });
  });
}