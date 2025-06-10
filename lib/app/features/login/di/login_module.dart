import 'package:cos_challenge/app/common/auth/domain/boundary/auth_data_source.dart';
import 'package:cos_challenge/app/features/login/domain/use_case/save_user.dart';
import 'package:cos_challenge/app/features/login/presentation/cubit/login_cubit.dart';
import 'package:injectable/injectable.dart';

@module
abstract class LoginModule {
  SaveUserUseCase saveUserUseCase(
    AuthDataSource authDataSource,
  ) =>
      SaveUserUseCaseImpl(authDataSource);

  LoginCubit loginCubit(
    SaveUserUseCase saveUserUseCase,
  ) =>
      LoginCubit(
        saveUserUseCase,
      );
}
