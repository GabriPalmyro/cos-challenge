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
import 'package:cos_challenge/app/features/login/di/login_module.dart' as _i870;
import 'package:cos_challenge/app/features/login/presentation/cubit/login_cubit.dart'
    as _i303;
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
    final loginModule = _$LoginModule();
    final authModule = _$AuthModule();
    gh.factory<_i303.LoginCubit>(() => loginModule.loginCubit());
    gh.factory<_i984.AuthDataSource>(() => authModule.authDataSource());
    return this;
  }
}

class _$LoginModule extends _i870.LoginModule {}

class _$AuthModule extends _i319.AuthModule {}
