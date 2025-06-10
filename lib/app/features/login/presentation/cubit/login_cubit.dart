import 'package:cos_challenge/app/core/errors/users_errors.dart';
import 'package:cos_challenge/app/features/login/domain/use_case/save_user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._saveUserUseCase) : super(const LoginInitial());

  final SaveUserUseCase _saveUserUseCase;

  Future<void> login(
    String email,
    String name,
  ) async {
    try {
      emit(const LoginLoading());
      await Future.delayed(const Duration(seconds: 2));
      await _saveUserUseCase.call(name, email);
      emit(const LoginSuccess());
    } catch (e) {
      emit(LoginFailure(InvalidCredentialsError()));
    }
  }
}
