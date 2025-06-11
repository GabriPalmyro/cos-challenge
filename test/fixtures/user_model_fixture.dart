import 'package:cos_challenge/app/common/auth/data/model/user_model.dart';

class UserModelFixture {
  static UserModel validUser() => const UserModel(
        name: 'Test User',
        email: 'test@example.com',
      );

  static UserModel anotherValidUser() => const UserModel(
        name: 'Another User',
        email: 'another@example.com',
      );

  static Map<String, dynamic> validUserJson() => {
        'name': 'Test User',
        'email': 'test@example.com',
      };
}
