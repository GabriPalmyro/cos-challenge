import 'package:cos_challenge/app/common/auth/data/data_source/auth_local_data_source.dart';
import 'package:cos_challenge/app/common/auth/data/model/user_model.dart';
import 'package:cos_challenge/app/common/local_database/adapters/user_box.dart';
import 'package:cos_challenge/app/core/errors/users_errors.dart';
import 'package:cos_challenge/app/core/utils/cos_strings.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_test/hive_test.dart';

void main() {
  late AuthLocalDataSource dataSource;

  group('AuthLocalDataSource Test |', () {
    setUpAll(() async {
      Hive.registerAdapter(UserBoxAdapter());
    });

    setUp(() async {
      await setUpTestHive();
      await Hive.openBox<UserBox>(CosStrings.userBox);
      dataSource = AuthLocalDataSource();
    });

    tearDown(() async {
      await Hive.box<UserBox>(CosStrings.userBox).close();
      await tearDownTestHive();
    });

    const userModel = UserModel(name: 'Test', email: 'test@example.com');

    test('should save and retrieve current user', () async {
      await dataSource.saveUser(userModel);
      final result = await dataSource.getCurrentUser();

      expect(result.email, userModel.email);
      expect(result.name, userModel.name);
    });

    test('should throw when no user exists', () async {
      expect(() async => await dataSource.getCurrentUser(), throwsA(isA<UserNotFoundError>()));
    });

    test('should delete existing user', () async {
      await dataSource.saveUser(userModel);
      await dataSource.deleteUser(userModel.email);

      expect(() async => await dataSource.getCurrentUser(), throwsA(isA<UserNotFoundError>()));
    });

    test('should throw when deleting non-existent user', () async {
      expect(() async => await dataSource.deleteUser('nonexistent@example.com'), throwsA(isA<UserNotFoundError>()));
    });
  });
}
