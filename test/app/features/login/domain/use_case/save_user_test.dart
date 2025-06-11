import 'package:cos_challenge/app/common/auth/data/model/user_model.dart';
import 'package:cos_challenge/app/common/auth/domain/boundary/auth_data_source.dart';
import 'package:cos_challenge/app/features/login/domain/use_case/save_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthDataSource extends Mock implements AuthDataSource {}

class MockUserModel extends Mock implements UserModel {}

void main() {
  late SaveUserUseCaseImpl saveUserUseCase;
  late MockAuthDataSource mockAuthDataSource;
  late MockUserModel mockUserModel;

  setUp(() {
    mockAuthDataSource = MockAuthDataSource();
    saveUserUseCase = SaveUserUseCaseImpl(mockAuthDataSource);
    mockUserModel = MockUserModel();

    registerFallbackValue(mockUserModel);
  });

  group('SaveUserUseCaseImpl Test |', () {
    test('should call authDataSource.saveUser with correct UserModel', () async {
      // Arrange
      const name = 'John Doe';
      const email = 'john.doe@example.com';
      when(() => mockAuthDataSource.saveUser(any())).thenAnswer((_) async {});

      // Act
      await saveUserUseCase.call(name, email);

      // Assert
      verify(
        () => mockAuthDataSource.saveUser(
          const UserModel(name: name, email: email),
        ),
      ).called(1);
    });

    test('should complete successfully when authDataSource succeeds', () async {
      // Arrange
      const name = 'Jane Smith';
      const email = 'jane.smith@example.com';
      when(() => mockAuthDataSource.saveUser(any())).thenAnswer((_) async {});

      // Act & Assert
      await expectLater(saveUserUseCase.call(name, email), completes);
    });

    test('should throw exception when authDataSource fails', () async {
      // Arrange
      const name = 'Error User';
      const email = 'error@example.com';
      when(() => mockAuthDataSource.saveUser(any())).thenThrow(Exception('Save failed'));

      // Act & Assert
      await expectLater(
        saveUserUseCase.call(name, email),
        throwsException,
      );
    });

    test('should throw exception when name is empty', () async {
      // Arrange
      const name = '';
      const email = 'test@example.com';

      // Act & Assert
      await expectLater(
        saveUserUseCase.call(name, email),
        throwsA(isA<Exception>()),
      );
    });

    test('should throw exception when email is empty', () async {
      // Arrange
      const name = 'Test User';
      const email = '';

      // Act & Assert
      await expectLater(
        saveUserUseCase.call(name, email),
        throwsA(isA<Exception>()),
      );
    });
  });
}
