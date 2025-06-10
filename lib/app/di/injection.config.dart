// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cos_challenge/app/common/auth/di/auth_module.dart' as _i319;
import 'package:cos_challenge/app/common/auth/domain/boundary/auth_data_source.dart'
    as _i984;
import 'package:cos_challenge/app/features/home/di/home_module.dart' as _i957;
import 'package:cos_challenge/app/features/home/domain/boundary/car_data_source.dart'
    as _i958;
import 'package:cos_challenge/app/features/home/domain/boundary/car_search_repository.dart'
    as _i792;
import 'package:cos_challenge/app/features/home/domain/use_case/get_cached_cars.dart'
    as _i209;
import 'package:cos_challenge/app/features/home/domain/use_case/get_car_by_vin.dart'
    as _i450;
import 'package:cos_challenge/app/features/home/domain/use_case/get_user.dart'
    as _i214;
import 'package:cos_challenge/app/features/home/presentation/cubit/car_search_cubit.dart'
    as _i833;
import 'package:cos_challenge/app/features/home/presentation/cubit/user_info_cubit.dart'
    as _i196;
import 'package:cos_challenge/app/features/login/di/login_module.dart' as _i870;
import 'package:cos_challenge/app/features/login/domain/use_case/save_user.dart'
    as _i705;
import 'package:cos_challenge/app/features/login/presentation/cubit/login_cubit.dart'
    as _i303;
import 'package:cos_challenge/app/features/splash/di/splash_module.dart'
    as _i622;
import 'package:cos_challenge/app/features/splash/domain/use_case/verify_user.dart'
    as _i309;
import 'package:cos_challenge/app/features/splash/presentation/cubit/splash_cubit.dart'
    as _i290;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt $initAppDependencies({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final authModule = _$AuthModule();
    final homeModule = _$HomeModule();
    final loginModule = _$LoginModule();
    final splashModule = _$SplashModule();
    gh.factory<_i984.AuthDataSource>(() => authModule.authDataSource());
    gh.factory<_i958.CarDataSource>(() => homeModule.carDataSource());
    gh.factory<_i792.CarSearchRepository>(
        () => homeModule.carSearchRepository());
    gh.factory<_i705.SaveUserUseCase>(
        () => loginModule.saveUserUseCase(gh<_i984.AuthDataSource>()));
    gh.factory<_i309.VerifyUserUseCase>(
        () => splashModule.getUserUseCase(gh<_i984.AuthDataSource>()));
    gh.factory<_i214.GetUserUseCase>(
        () => homeModule.getUserUseCase(gh<_i984.AuthDataSource>()));
    gh.factory<_i450.GetCarByVinUseCase>(() => homeModule.getCarByVinUseCase(
          gh<_i792.CarSearchRepository>(),
          gh<_i958.CarDataSource>(),
          gh<_i984.AuthDataSource>(),
        ));
    gh.factory<_i290.SplashCubit>(
        () => splashModule.splashCubit(gh<_i309.VerifyUserUseCase>()));
    gh.factory<_i209.GetCachedCarsUseCase>(
        () => homeModule.getCachedCarsUseCase(gh<_i958.CarDataSource>()));
    gh.factory<_i833.CarSearchCubit>(() => homeModule.carSearchCubit(
          gh<_i450.GetCarByVinUseCase>(),
          gh<_i209.GetCachedCarsUseCase>(),
        ));
    gh.factory<_i196.UserInfoCubit>(
        () => homeModule.userInfoCubit(gh<_i214.GetUserUseCase>()));
    gh.factory<_i303.LoginCubit>(
        () => loginModule.loginCubit(gh<_i705.SaveUserUseCase>()));
    return this;
  }
}

class _$AuthModule extends _i319.AuthModule {}

class _$HomeModule extends _i957.HomeModule {}

class _$LoginModule extends _i870.LoginModule {}

class _$SplashModule extends _i622.SplashModule {}
