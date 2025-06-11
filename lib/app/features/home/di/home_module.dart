import 'package:cos_challenge/app/common/auth/domain/boundary/auth_data_source.dart';
import 'package:cos_challenge/app/features/home/data/data_source/car_local_data_source.dart';
import 'package:cos_challenge/app/features/home/data/repository/car_search_repository_impl.dart';
import 'package:cos_challenge/app/features/home/domain/boundary/car_data_source.dart';
import 'package:cos_challenge/app/features/home/domain/boundary/car_search_repository.dart';
import 'package:cos_challenge/app/features/home/domain/use_case/get_cached_cars.dart';
import 'package:cos_challenge/app/features/home/domain/use_case/get_car_by_vin.dart';
import 'package:cos_challenge/app/features/home/domain/use_case/get_user.dart';
import 'package:cos_challenge/app/features/home/domain/use_case/logout_user.dart';
import 'package:cos_challenge/app/features/home/presentation/cubit/car_search_cubit.dart';
import 'package:cos_challenge/app/features/home/presentation/cubit/user_info_cubit.dart';
import 'package:injectable/injectable.dart';

@module
abstract class HomeModule {
  CarDataSource carDataSource() => CarLocalDataSourceImpl();

  CarSearchRepository carSearchRepository() => CarSearchRepositoryImpl();

  GetUserUseCase getUserUseCase(
    AuthDataSource authDataSource,
  ) =>
      GetUserUseCaseImpl(
        authDataSource,
      );

  LogoutUserUseCase getLogoutUserUseCase(
    AuthDataSource authDataSource,
  ) =>
      LogoutUserUseCaseImpl(
        authDataSource,
      );

  UserInfoCubit userInfoCubit(
    GetUserUseCase getUserUseCase,
    LogoutUserUseCase logoutUserUseCase,
  ) =>
      UserInfoCubit(
        getUserUseCase,
        logoutUserUseCase,
      );

  GetCarByVinUseCase getCarByVinUseCase(
    CarSearchRepository carSearchRepository,
    CarDataSource carDataSource,
    AuthDataSource authDataSource,
  ) =>
      GetCarByVinUseCaseImpl(
        carSearchRepository,
        carDataSource,
        authDataSource,
      );

  GetCachedCarsUseCase getCachedCarsUseCase(
    CarDataSource carDataSource,
  ) =>
      GetCachedCarsUseCaseImpl(
        carDataSource,
      );

  CarSearchCubit carSearchCubit(
    GetCarByVinUseCase getCarByVinUseCase,
    GetCachedCarsUseCase getCachedCarsUseCase,
  ) =>
      CarSearchCubit(
        getCarByVinUseCase,
        getCachedCarsUseCase,
      );
}
