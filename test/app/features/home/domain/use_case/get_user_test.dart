import 'package:cos_challenge/app/common/auth/domain/boundary/auth_data_source.dart';
import 'package:cos_challenge/app/core/errors/users_errors.dart';
import 'package:cos_challenge/app/features/home/domain/use_case/get_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../fixtures/user_model_fixture.dart';

class MockAuthDataSource extends Mock implements AuthDataSource {}

void main() {
  group('GetUserUseCase', () {
    late MockAuthDataSource mockAuthDataSource;
    late GetUserUseCase getUserUseCase;

    setUp(() {
      mockAuthDataSource = MockAuthDataSource();
      getUserUseCase = GetUserUseCaseImpl(mockAuthDataSource);
    });

    group('call', () {
      test('should return user when user exists', () async {
        // Arrange
        final expectedUser = UserModelFixture.validUser();
        when(() => mockAuthDataSource.getCurrentUser())
            .thenAnswer((_) async => expectedUser);

        // Act
        final result = await getUserUseCase.call();

        // Assert
        expect(result, equals(expectedUser));
        verify(() => mockAuthDataSource.getCurrentUser()).called(1);
      });

      test('should throw UserNotFoundError when user does not exist', () async {
        // Arrange
        when(() => mockAuthDataSource.getCurrentUser())
            .thenThrow(UserNotFoundError());

        // Act & Assert
        expect(() => getUserUseCase.call(), throwsA(isA<UserNotFoundError>()));
      });

      test('should call getCurrentUser exactly once', () async {
        // Arrange
        when(() => mockAuthDataSource.getCurrentUser())
            .thenAnswer((_) async => UserModelFixture.validUser());

        // Act
        await getUserUseCase.call();

        // Assert
        verify(() => mockAuthDataSource.getCurrentUser()).called(1);
        verifyNoMoreInteractions(mockAuthDataSource);
      });
    });
  });
}
