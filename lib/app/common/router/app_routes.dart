import 'package:cos_challenge/app/common/router/routes.dart';
import 'package:cos_challenge/app/features/home/data/model/car_info_model.dart';
import 'package:cos_challenge/app/features/home/presentation/cubit/car_search_cubit.dart';
import 'package:cos_challenge/app/features/home/presentation/cubit/user_info_cubit.dart';
import 'package:cos_challenge/app/features/home/presentation/page/car_info_page.dart';
import 'package:cos_challenge/app/features/home/presentation/page/home_page.dart';
import 'package:cos_challenge/app/features/login/presentation/cubit/login_cubit.dart';
import 'package:cos_challenge/app/features/login/presentation/page/login_page.dart';
import 'package:cos_challenge/app/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:cos_challenge/app/features/splash/presentation/page/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class AppRouter {
  AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final Map<String, WidgetBuilder> allRoutes = {
      Routes.splash: (context) => SplashPage(
            cubit: GetIt.I.get<SplashCubit>(),
          ),
      Routes.login: (context) => LoginPage(
            cubit: GetIt.I.get<LoginCubit>(),
          ),
      Routes.home: (context) => HomePage(
            userCubit: GetIt.I.get<UserInfoCubit>(),
            carCubit: GetIt.I.get<CarSearchCubit>(),
          ),
      Routes.carInfo: (context) => CarInfoPage(
            carInfo: settings.arguments as CarInfoModel,
          ),
    };

    final WidgetBuilder? builder = allRoutes[settings.name];

    if (builder != null) {
      return MaterialPageRoute(
        builder: (ctx) => builder(ctx),
        settings: settings,
      );
    }

    return MaterialPageRoute(
      builder: (ctx) => Scaffold(
        appBar: AppBar(title: const Text('Rota não encontrada')),
        body: Center(child: Text('Rota "${settings.name}" não encontrada')),
      ),
      settings: settings,
    );
  }
}
