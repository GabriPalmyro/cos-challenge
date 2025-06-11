import 'package:cos_challenge/app/common/auth/data/model/user_model.dart';
import 'package:cos_challenge/app/common/auth/domain/boundary/auth_data_source.dart';
import 'package:cos_challenge/app/core/errors/users_errors.dart';

abstract class VerifyUserUseCase {
  Future<UserModel> call();
}

class VerifyUserUseCaseImpl implements VerifyUserUseCase {
  VerifyUserUseCaseImpl(this._authDataSource);
  final AuthDataSource _authDataSource;

  @override
  Future<UserModel> call() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      return await _authDataSource.getCurrentUser();
    } catch (e) {
      throw const UserNotFoundError();
    }
  }
}
