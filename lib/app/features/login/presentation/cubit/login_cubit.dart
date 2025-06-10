import 'package:cos_challenge/app/core/errors/users_errors.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginInitial());

  void login(
    String email,
    String password,
  ) {
    emit(const LoginLoading());
    Future.delayed(const Duration(seconds: 2), () {
      emit(const LoginSuccess());
    });
  }
}
