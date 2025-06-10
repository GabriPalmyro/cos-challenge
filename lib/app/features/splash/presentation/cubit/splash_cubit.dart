import 'package:bloc/bloc.dart';
import 'package:cos_challenge/app/features/splash/domain/use_case/get_user.dart';
import 'package:equatable/equatable.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this._getUserUseCase) : super(const SplashInitial());

  final GetUserUseCase _getUserUseCase;

  Future<void> checkUser() async {
    try {
      emit(const SplashInitial());
      await _getUserUseCase.call();
      emit(const SplashUserFound());
    } catch (e) {
      emit(const SplashUserNotFound());
    }
  }
}
