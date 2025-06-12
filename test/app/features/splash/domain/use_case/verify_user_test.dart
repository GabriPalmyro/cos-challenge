import 'package:cos_challenge/app/common/auth/data/model/user_model.dart';
import 'package:cos_challenge/app/common/auth/domain/boundary/auth_data_source.dart';
import 'package:cos_challenge/app/core/errors/users_errors.dart';
import 'package:cos_challenge/app/features/splash/domain/use_case/verify_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthDataSource extends Mock implements AuthDataSource {}

void main() {
  late MockAuthDataSource mockAuthDataSource;
  late VerifyUserUseCaseImpl useCase;

  setUp(() {
    mockAuthDataSource = MockAuthDataSource();
    useCase = VerifyUserUseCaseImpl(mockAuthDataSource);
  });

  group('VerifyUserUseCaseImpl Test', () {
    test('should return UserModel when getCurrentUser succeeds', () async {
      // Arrange
      const userModel = UserModel(name: 'Test', email: 'test@example.com');
      when(() => mockAuthDataSource.getCurrentUser())
          .thenAnswer((_) async => userModel);

      // Act
      final result = await useCase.call();

      // Assert
      expect(result, equals(userModel));
      verify(() => mockAuthDataSource.getCurrentUser()).called(1);
    });

    test('should throw UserNotFoundError when getCurrentUser throws exception', () async {
      // Arrange
      when(() => mockAuthDataSource.getCurrentUser())
          .thenThrow(Exception('Network error'));

      // Act & Assert
      await expectLater(() => useCase.call(), throwsA(isA<UserNotFoundError>()));
      verify(() => mockAuthDataSource.getCurrentUser()).called(1);
    });

    test('should throw UserNotFoundError when getCurrentUser returns null', () async {
      // Arrange
      when(() => mockAuthDataSource.getCurrentUser())
          .thenThrow(Exception('User not found'));

      // Act & Assert
      await expectLater(() => useCase.call(), throwsA(isA<UserNotFoundError>()));
      verify(() => mockAuthDataSource.getCurrentUser()).called(1);
    });
  });
}