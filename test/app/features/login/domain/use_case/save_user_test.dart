import 'package:cos_challenge/app/common/auth/domain/boundary/auth_data_source.dart';
import 'package:cos_challenge/app/features/login/domain/use_case/save_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthDataSource extends Mock implements AuthDataSource {}

void main() {
  group('SaveUserUseCase', () {
    late MockAuthDataSource mockAuthDataSource;
    late SaveUserUseCase saveUserUseCase;

    setUp(() {
      mockAuthDataSource = MockAuthDataSource();
      saveUserUseCase = SaveUserUseCaseImpl(mockAuthDataSource);
    });

    group('call', () {
      const testName = 'Test User';
      const testEmail = 'test@example.com';

      test('should save user successfully', () async {
        // Arrange
        when(() => mockAuthDataSource.saveUser(any()))
            .thenAnswer((_) async {});

        // Act
        await saveUserUseCase.call(testName, testEmail);

        // Assert
        verify(() => mockAuthDataSource.saveUser(any())).called(1);
      });

      test('should save user with correct data', () async {
        // Arrange
        when(() => mockAuthDataSource.saveUser(any()))
            .thenAnswer((_) async {});

        // Act
        await saveUserUseCase.call(testName, testEmail);

        // Assert
        final captured = verify(() => mockAuthDataSource.saveUser(captureAny())).captured;
        final savedUser = captured.first;
        
        expect(savedUser.name, equals(testName));
        expect(savedUser.email, equals(testEmail));
      });

      test('should throw exception when save fails', () async {
        // Arrange
        when(() => mockAuthDataSource.saveUser(any()))
            .thenThrow(Exception('Save failed'));

        // Act & Assert
        expect(
          () => saveUserUseCase.call(testName, testEmail),
          throwsException,
        );

        verify(() => mockAuthDataSource.saveUser(any())).called(1);
      });

      test('should call saveUser exactly once', () async {
        // Arrange
        when(() => mockAuthDataSource.saveUser(any()))
            .thenAnswer((_) async {});

        // Act
        await saveUserUseCase.call(testName, testEmail);

        // Assert
        verify(() => mockAuthDataSource.saveUser(any())).called(1);
        verifyNoMoreInteractions(mockAuthDataSource);
      });
    });
  });
}
