import 'package:bloc/bloc.dart';
import 'package:cos_challenge/app/common/auth/data/model/user_model.dart';
import 'package:cos_challenge/app/core/errors/failure.dart';
import 'package:cos_challenge/app/core/errors/users_errors.dart';
import 'package:cos_challenge/app/features/home/domain/use_case/get_user.dart';
import 'package:equatable/equatable.dart';

part 'user_info_state.dart';

class UserInfoCubit extends Cubit<UserInfoState> {
  UserInfoCubit(this._getUserUseCase) : super(const UserInfoInitial());

  final GetUserUseCase _getUserUseCase;

  Future<void> getUserInfo() async {
    try {
      final user = await _getUserUseCase.call();
      emit(UserInfoLoaded(user));
    } catch (e) {
      emit(UserInfoError(UserNotFoundError()));
    }
  }

  Future<void> logout() async {
    // try {
    //   emit(const UserInfoInitial());
    //   await _getUserUseCase.logout();
    //   emit(UserInfoLoggedOut());
    // } catch (e) {
    //   emit(UserInfoError(Failure(message: 'Logout failed')));
    // }
  }
}
