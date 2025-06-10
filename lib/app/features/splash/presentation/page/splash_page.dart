import 'package:cos_challenge/app/common/router/router.dart';
import 'package:cos_challenge/app/design/design.dart';
import 'package:cos_challenge/app/design/tokens/cos_images.dart';
import 'package:cos_challenge/app/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatelessWidget with NavigationDelegate {
  const SplashPage({
    required this.cubit,
    super.key,
  });

  final SplashCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      bloc: cubit..checkUser(),
      listener: (context, state) {
        if (state is SplashUserFound) {
          replaceWith(context, Routes.home);
        } else if (state is SplashUserNotFound) {
          replaceWith(context, Routes.login);
        }
      },
      child: Scaffold(
        backgroundColor: CosColors.background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                CosImages.logo,
                width: 200,
                height: 200,
              ),
              const SizedBox(height: CosSpacing.xl),
              const CircularProgressIndicator(
                color: CosColors.primary,
                strokeWidth: 4.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
