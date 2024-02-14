part of 'get_user_cubit.dart';

sealed class GetUserState extends Equatable {
  const GetUserState();

  @override
  List<Object> get props => [];
}

final class GetUserInitial extends GetUserState {}

final class GetUserSuccess extends GetUserState {
  final UserModel userModel;

  const GetUserSuccess(this.userModel);
  @override
  List<Object> get props => [userModel];
}

final class GetUserFailed extends GetUserState {
  final String message;

  const GetUserFailed(this.message);
}
