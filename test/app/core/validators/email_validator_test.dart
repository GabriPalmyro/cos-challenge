
import 'package:cos_challenge/app/core/validators/email_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EmailValidator Test |', () {
    group('validate() |', () {
      test('should return null for valid email addresses', () {
        // Valid email formats
        expect(EmailValidator.validate('test@example.com'), isNull);
        expect(EmailValidator.validate('user.name@domain.org'), isNull);
        expect(EmailValidator.validate('email+tag@example.co.uk'), isNull);
        expect(EmailValidator.validate('firstname.lastname@company.com'), isNull);
        expect(EmailValidator.validate('test123@gmail.com'), isNull);
        expect(EmailValidator.validate('a@b.co'), isNull);
        expect(EmailValidator.validate('test.email-with-dash@example.com'), isNull);
        expect(EmailValidator.validate('x.y.z@example.com'), isNull);
        expect(EmailValidator.validate('example@s.example'), isNull);
      });

      test('should return error message for null input', () {
        expect(EmailValidator.validate(null), equals('Email cannot be empty'));
      });

      test('should return error message for empty input', () {
        expect(EmailValidator.validate(''), equals('Email cannot be empty'));
      });

      test('should return error message for whitespace only input', () {
        expect(EmailValidator.validate('   '), equals('Please enter a valid email'));
      });

      test('should return error message for Please enter a valid emails', () {
        // Missing @ symbol
        expect(EmailValidator.validate('testexample.com'), equals('Please enter a valid email'));
        
        // Missing domain
        expect(EmailValidator.validate('test@'), equals('Please enter a valid email'));
        
        // Missing username
        expect(EmailValidator.validate('@example.com'), equals('Please enter a valid email'));
        
        // Missing top-level domain
        expect(EmailValidator.validate('test@example'), equals('Please enter a valid email'));
      });

      test('should return error message for edge cases', () {
        // Very long email
        final longEmail = '${'a' * 100}@${'b' * 100}.com';
        expect(EmailValidator.validate(longEmail), isNull);
        
        // Email with special characters in local part
        expect(EmailValidator.validate('test!#\$%&\'*+-/=?^_`{|}~@example.com'), isNull);
      });
    });

    group('EmailRegEx Test |', () {
      test('should match valid email patterns', () {
        expect(EmailRegEx.email.hasMatch('test@example.com'), isTrue);
        expect(EmailRegEx.email.hasMatch('user.name@domain.org'), isTrue);
        expect(EmailRegEx.email.hasMatch('email+tag@example.co.uk'), isTrue);
      });

      test('should not match invalid email patterns', () {
        expect(EmailRegEx.email.hasMatch('invalid-email'), isFalse);
        expect(EmailRegEx.email.hasMatch('@missing-local.com'), isFalse);
        expect(EmailRegEx.email.hasMatch('missing-domain@'), isFalse);
        expect(EmailRegEx.email.hasMatch('test@@example.com'), isFalse);
      });
    });
  });
}