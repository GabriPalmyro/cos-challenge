part of 'splash_cubit.dart';

sealed class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

final class SplashInitial extends SplashState {
  const SplashInitial();

  @override
  List<Object> get props => [];
}

final class SplashUserFound extends SplashState {
  const SplashUserFound();

  @override
  List<Object> get props => [];
}

final class SplashUserNotFound extends SplashState {
  const SplashUserNotFound();

  @override
  List<Object> get props => [];
}
