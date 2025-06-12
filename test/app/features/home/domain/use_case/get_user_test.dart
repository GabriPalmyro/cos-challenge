import 'package:cos_challenge/app/common/auth/data/model/user_model.dart';
import 'package:cos_challenge/app/common/auth/domain/boundary/auth_data_source.dart';
import 'package:cos_challenge/app/core/errors/users_errors.dart';
import 'package:cos_challenge/app/features/home/domain/use_case/get_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthDataSource extends Mock implements AuthDataSource {}

void main() {
  late GetUserUseCaseImpl useCase;
  late MockAuthDataSource mockAuthDataSource;

  setUp(() {
    mockAuthDataSource = MockAuthDataSource();
    useCase = GetUserUseCaseImpl(mockAuthDataSource);
  });

  group('GetUserUseCaseImpl Test', () {
    test('should return UserModel when getCurrentUser succeeds', () async {
      // Arrange
      const expectedUser = UserModel(name: 'Test User', email: 'test@example.com');
      when(() => mockAuthDataSource.getCurrentUser()).thenAnswer((_) async => expectedUser);

      // Act
      final result = await useCase.call();

      // Assert
      expect(result, equals(expectedUser));
      verify(() => mockAuthDataSource.getCurrentUser()).called(1);
    });

    test('should throw UserNotFoundError when getCurrentUser throws exception', () async {
      // Arrange
      when(() => mockAuthDataSource.getCurrentUser()).thenThrow(Exception('Network error'));

      // Act & Assert
      await expectLater(() => useCase.call(), throwsA(isA<UserNotFoundError>()));
      verify(() => mockAuthDataSource.getCurrentUser()).called(1);
    });
  });
}
