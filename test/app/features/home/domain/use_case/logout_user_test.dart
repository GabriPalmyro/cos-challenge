import 'package:cos_challenge/app/common/auth/data/model/user_model.dart';
import 'package:cos_challenge/app/common/auth/domain/boundary/auth_data_source.dart';
import 'package:cos_challenge/app/features/home/domain/use_case/logout_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthDataSource extends Mock implements AuthDataSource {}
void main() {
  group('LogoutUserUseCaseImpl Test', () {
    late MockAuthDataSource mockAuthDataSource;
    late LogoutUserUseCaseImpl useCase;

    const mockUser = UserModel(name: 'Test User', email: 'test@example.com');

    setUp(() {
      mockAuthDataSource = MockAuthDataSource();
      useCase = LogoutUserUseCaseImpl(mockAuthDataSource);
    });

    test('should call getCurrentUser and deleteUser with correct email', () async {
      // Arrange
      when(() => mockAuthDataSource.getCurrentUser()).thenAnswer((_) async => mockUser);
      when(() => mockAuthDataSource.deleteUser(any())).thenAnswer((_) async {});

      // Act
      await useCase.call();

      // Assert
      verify(() => mockAuthDataSource.getCurrentUser()).called(1);
      verify(() => mockAuthDataSource.deleteUser('test@example.com')).called(1);
    });

    test('should throw exception when getCurrentUser fails', () async {
      // Arrange
      when(() => mockAuthDataSource.getCurrentUser()).thenThrow(Exception('User not found'));

      // Act & Assert
      expect(() => useCase.call(), throwsException);
      verify(() => mockAuthDataSource.getCurrentUser()).called(1);
      verifyNever(() => mockAuthDataSource.deleteUser(any()));
    });

    test('should throw exception when deleteUser fails', () async {
      // Arrange
      when(() => mockAuthDataSource.getCurrentUser()).thenAnswer((_) async => mockUser);
      when(() => mockAuthDataSource.deleteUser(any())).thenThrow(Exception('Delete failed'));

      // Act & Assert
      await expectLater(() => useCase.call(), throwsException);
      verify(() => mockAuthDataSource.getCurrentUser()).called(1);
      verify(() => mockAuthDataSource.deleteUser('test@example.com')).called(1);
    });
  });
}
