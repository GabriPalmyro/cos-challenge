import 'package:cos_challenge/app/common/auth/data/data_source/auth_local_data_source.dart';
import 'package:cos_challenge/app/common/auth/domain/boundary/auth_data_source.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AuthModule {
  AuthDataSource authDataSource() => AuthLocalDataSource();
}
