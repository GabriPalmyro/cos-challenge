part of 'user_info_cubit.dart';

sealed class UserInfoState extends Equatable {
  const UserInfoState();

  @override
  List<Object> get props => [];
}

final class UserInfoInitial extends UserInfoState {
  const UserInfoInitial();

  @override
  List<Object> get props => [];
}

final class UserInfoLoaded extends UserInfoState {
  const UserInfoLoaded(this.user);
  final UserModel user;

  @override
  List<Object> get props => [user];
}

final class UserLogout extends UserInfoState {
  const UserLogout();

  @override
  List<Object> get props => [];
}

final class UserInfoError extends UserInfoState {
  const UserInfoError(this.failure);
  final Failure failure;

  @override
  List<Object> get props => [failure];
}
