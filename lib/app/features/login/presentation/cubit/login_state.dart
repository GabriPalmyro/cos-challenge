part of 'login_cubit.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {
  const LoginInitial();

  @override
  List<Object> get props => [];
}

final class LoginLoading extends LoginState {
  const LoginLoading();

  @override
  List<Object> get props => [];
}

final class LoginSuccess extends LoginState {
  const LoginSuccess();

  @override
  List<Object> get props => [];
}

final class LoginFailure extends LoginState {
  const LoginFailure(this.error);
  final UsersErrors error;

  @override
  List<Object> get props => [error];
}
