import 'package:cos_challenge/app/core/errors/cars_errors.dart';
import 'package:cos_challenge/app/core/errors/users_errors.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CarsErrors', () {
    group('CarsNotFoundError', () {
      test('should create error with default message', () {
        // Act
        final error = CarsNotFoundError();

        // Assert
        expect(error.message, 'Car not found.');
        expect(error, isA<CarsErrors>());
      });

      test('should create error with custom message', () {
        // Arrange
        const customMessage = 'Custom error message';

        // Act
        final error = CarsNotFoundError(message: customMessage);

        // Assert
        expect(error.message, customMessage);
      });

      test('should have proper toString representation', () {
        // Arrange
        final error = CarsNotFoundError();

        // Act
        final result = error.toString();

        // Assert
        expect(result, contains('CarsNotFoundError'));
        expect(result, contains('Car not found.'));
      });
    });

    group('CarMaintenceDelayException', () {
      test('should create exception with correct properties', () {
        // Act
        final exception = CarMaintenceDelayException();

        // Assert
        expect(exception, isA<CarsErrors>());
        expect(exception.toString(), contains('CarMaintenceDelayException'));
      });
    });

    group('CarsSearchTimeoutException', () {
      test('should create timeout exception', () {
        // Act
        final exception = CarsSearchTimeoutException();

        // Assert
        expect(exception, isA<CarsErrors>());
        expect(exception.toString(), contains('CarsSearchTimeoutException'));
      });
    });

    group('CarsClientException', () {
      test('should create client exception', () {
        // Act
        final exception = CarsClientException();

        // Assert
        expect(exception, isA<CarsErrors>());
        expect(exception.toString(), contains('CarsClientException'));
      });
    });
  });

  group('UsersErrors', () {
    group('UserNotFoundError', () {
      test('should create error with default message', () {
        // Act
        final error = UserNotFoundError();

        // Assert
        expect(error.message, 'User not found');
        expect(error, isA<UsersErrors>());
      });

      test('should create error with custom message', () {
        // Arrange
        const customMessage = 'Custom user error';

        // Act
        final error = UserNotFoundError(message: customMessage);

        // Assert
        expect(error.message, customMessage);
      });

      test('should have proper toString representation', () {
        // Arrange
        final error = UserNotFoundError();

        // Act
        final result = error.toString();

        // Assert
        expect(result, contains('UserNotFoundError'));
        expect(result, contains('User not found'));
      });
    });
  });
}
