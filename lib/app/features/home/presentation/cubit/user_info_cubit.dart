import 'package:bloc/bloc.dart';
import 'package:cos_challenge/app/common/auth/data/model/user_model.dart';
import 'package:cos_challenge/app/core/errors/failure.dart';
import 'package:cos_challenge/app/core/errors/users_errors.dart';
import 'package:cos_challenge/app/features/home/domain/use_case/get_user.dart';
import 'package:cos_challenge/app/features/home/domain/use_case/logout_user.dart';
import 'package:equatable/equatable.dart';

part 'user_info_state.dart';

class UserInfoCubit extends Cubit<UserInfoState> {
  UserInfoCubit(this._getUserUseCase, this._logoutUserUseCase) : super(const UserInfoInitial());

  final GetUserUseCase _getUserUseCase;
  final LogoutUserUseCase _logoutUserUseCase;

  Future<void> getUserInfo() async {
    try {
      final user = await _getUserUseCase.call();
      emit(UserInfoLoaded(user));
    } catch (e) {
      emit(const UserInfoError(UserNotFoundError()));
    }
  }

  Future<void> logout() async {
    final user = await _getUserUseCase.call();

    try {
      await _logoutUserUseCase.call();
      emit(UserLogout(user));
    } catch (e) {
      emit(UserInfoLoaded(user));
    }
  }
}
