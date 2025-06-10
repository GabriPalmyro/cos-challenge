import 'package:cos_challenge/app/features/login/presentation/cubit/login_cubit.dart';
import 'package:injectable/injectable.dart';

@module
abstract class LoginModule {
  LoginCubit loginCubit() => LoginCubit();
}
