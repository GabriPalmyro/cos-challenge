import 'package:cos_challenge/app/common/auth/data/model/user_model.dart';
import 'package:cos_challenge/app/common/auth/domain/boundary/auth_data_source.dart';
import 'package:cos_challenge/app/core/errors/users_errors.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthDataSource extends Mock implements AuthDataSource {
  static void setupMockSuccess({
    UserModel? user,
  }) {
    final mockAuthDataSource = MockAuthDataSource();
    
    when(() => mockAuthDataSource.getCurrentUser())
        .thenAnswer((_) async => user ?? const UserModel(name: 'Test User', email: 'test@example.com'));
    
    when(() => mockAuthDataSource.saveUser(any()))
        .thenAnswer((_) async {});
    
    when(() => mockAuthDataSource.deleteUser(any()))
        .thenAnswer((_) async {});
  }

  static void setupMockFailure() {
    final mockAuthDataSource = MockAuthDataSource();
    
    when(() => mockAuthDataSource.getCurrentUser())
        .thenThrow(UserNotFoundError());
    
    when(() => mockAuthDataSource.saveUser(any()))
        .thenThrow(InvalidCredentialsError());
    
    when(() => mockAuthDataSource.deleteUser(any()))
        .thenThrow(UserNotFoundError());
  }
}
