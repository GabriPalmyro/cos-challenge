import 'package:cos_challenge/app/common/auth/domain/boundary/auth_data_source.dart';
import 'package:cos_challenge/app/features/splash/domain/use_case/get_user.dart';
import 'package:cos_challenge/app/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:injectable/injectable.dart';

@module
abstract class SplashModule {
  GetUserUseCase getUserUseCase(
    AuthDataSource authDataSource,
  ) =>
      GetUserUseCaseImpl(authDataSource);

  SplashCubit splashCubit(
    GetUserUseCase getUserUseCase,
  ) =>
      SplashCubit(
        getUserUseCase,
      );
}
