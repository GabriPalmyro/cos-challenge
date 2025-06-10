import 'package:cos_challenge/app/common/auth/data/model/user_model.dart';
import 'package:cos_challenge/app/common/auth/domain/boundary/auth_data_source.dart';

abstract class SaveUserUseCase {
  Future<void> call(String name, String email);
}

class SaveUserUseCaseImpl implements SaveUserUseCase {
  SaveUserUseCaseImpl(this._authDataSource);
  final AuthDataSource _authDataSource;

  @override
  Future<void> call(String name, String email) async {
    await Future.delayed(const Duration(seconds: 2));
    return await _authDataSource.saveUser(
      UserModel(
        name: name,
        email: email,
      ),
    );
  }
}
