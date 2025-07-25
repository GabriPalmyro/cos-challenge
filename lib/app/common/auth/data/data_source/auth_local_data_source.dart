import 'package:cos_challenge/app/common/auth/data/model/user_model.dart';
import 'package:cos_challenge/app/common/auth/domain/boundary/auth_data_source.dart';
import 'package:cos_challenge/app/common/local_database/boxes.dart';
import 'package:cos_challenge/app/core/errors/users_errors.dart';

class AuthLocalDataSource implements AuthDataSource {
  @override
  Future<void> deleteUser(String email) {
    try {
      final userBox = Boxes.userBox;
      if (userBox.containsKey(email)) {
        return userBox.delete(email);
      } else {
        throw const UserNotFoundError();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> getCurrentUser() {
    try {
      final userBox = Boxes.userBox;
      final user = userBox.values.isNotEmpty ? userBox.values.first : null;
      if (user != null) {
        return Future.value(UserModel.fromBox(user));
      } else {
        throw const UserNotFoundError();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> saveUser(UserModel user) async {
    try {
      final userBox = Boxes.userBox;
      await userBox.put(user.email, user.toBox());
    } catch (e) {
      rethrow;
    }
  }
}
