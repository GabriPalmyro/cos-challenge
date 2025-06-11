import 'package:cos_challenge/app/common/auth/domain/boundary/auth_data_source.dart';

abstract class LogoutUserUseCase {
  Future<void> call();
}

class LogoutUserUseCaseImpl implements LogoutUserUseCase {
  LogoutUserUseCaseImpl(this.authDataSource);

  final AuthDataSource authDataSource;

  @override
  Future<void> call() async {
    final user = await authDataSource.getCurrentUser();
    await authDataSource.deleteUser(user.email);
  }
}
