import 'package:cos_challenge/app/common/auth/domain/boundary/auth_data_source.dart';
import 'package:cos_challenge/app/core/errors/users_errors.dart';
import 'package:cos_challenge/app/features/splash/domain/use_case/verify_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../fixtures/user_model_fixture.dart';

class MockAuthDataSource extends Mock implements AuthDataSource {}

void main() {
  group('VerifyUserUseCase', () {
    late MockAuthDataSource mockAuthDataSource;
    late VerifyUserUseCase verifyUserUseCase;

    setUp(() {
      mockAuthDataSource = MockAuthDataSource();
      verifyUserUseCase = VerifyUserUseCaseImpl(mockAuthDataSource);
    });

    group('call', () {
      test('should complete successfully when user exists', () async {
        // Arrange
        final expectedUser = UserModelFixture.validUser();
        when(() => mockAuthDataSource.getCurrentUser())
            .thenAnswer((_) async => expectedUser);

        // Act
        final result = await verifyUserUseCase.call();

        // Assert
        expect(result, equals(expectedUser));
        verify(() => mockAuthDataSource.getCurrentUser()).called(1);
      });

      test('should throw UserNotFoundError when user does not exist', () async {
        // Arrange
        when(() => mockAuthDataSource.getCurrentUser())
            .thenThrow(UserNotFoundError());

        // Act & Assert
        expect(() => verifyUserUseCase.call(), throwsA(isA<UserNotFoundError>()));
      });

      test('should call getCurrentUser exactly once', () async {
        // Arrange
        when(() => mockAuthDataSource.getCurrentUser())
            .thenAnswer((_) async => UserModelFixture.validUser());

        // Act
        await verifyUserUseCase.call();

        // Assert
        verify(() => mockAuthDataSource.getCurrentUser()).called(1);
        verifyNoMoreInteractions(mockAuthDataSource);
      });
    });
  });
}
