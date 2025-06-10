import 'package:cos_challenge/app/common/auth/domain/boundary/auth_data_source.dart';
import 'package:cos_challenge/app/features/splash/domain/use_case/verify_user.dart';
import 'package:cos_challenge/app/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:injectable/injectable.dart';

@module
abstract class SplashModule {
  VerifyUserUseCase getUserUseCase(
    AuthDataSource authDataSource,
  ) =>
      VerifyUserUseCaseImpl(authDataSource);

  SplashCubit splashCubit(
    VerifyUserUseCase getUserUseCase,
  ) =>
      SplashCubit(
        getUserUseCase,
      );
}
