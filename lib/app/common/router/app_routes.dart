import 'package:cos_challenge/app/common/router/routes.dart';
import 'package:cos_challenge/app/features/home/presentation/page/home_page.dart';
import 'package:cos_challenge/app/features/login/presentation/cubit/login_cubit.dart';
import 'package:cos_challenge/app/features/login/presentation/page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class AppRouter {
  AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final Map<String, WidgetBuilder> allRoutes = {
      Routes.main: (context) => const HomePage(),
      Routes.login: (context) =>  LoginPage(
        cubit: GetIt.I.get<LoginCubit>(),
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
