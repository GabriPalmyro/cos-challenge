import 'package:cos_challenge/app/common/auth/data/model/user_model.dart';

abstract class AuthDataSource {
  Future<UserModel> getCurrentUser();
  Future<void> saveUser(UserModel user);
  Future<void> deleteUser(String email);
}