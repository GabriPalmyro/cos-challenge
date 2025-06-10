import 'package:bloc/bloc.dart';
import 'package:cos_challenge/app/features/splash/domain/use_case/verify_user.dart';
import 'package:equatable/equatable.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this._verifyUserUseCase) : super(const SplashInitial());

  final VerifyUserUseCase _verifyUserUseCase;

  Future<void> checkUser() async {
    try {
      emit(const SplashInitial());
      await _verifyUserUseCase.call();
      emit(const SplashUserFound());
    } catch (e) {
      emit(const SplashUserNotFound());
    }
  }
}
