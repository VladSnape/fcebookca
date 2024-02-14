part of 'get_user_info_cubit.dart';

sealed class GetUserInfoState extends Equatable {
  const GetUserInfoState();

  @override
  List<Object> get props => [];
}

final class GetUserInfoInitial extends GetUserInfoState {}

final class GetUserInfoLoading extends GetUserInfoState {}

final class GetUserInfoSuccess extends GetUserInfoState {
  final UserModel userModel;

  const GetUserInfoSuccess(this.userModel);
  @override
  List<Object> get props => [userModel];
}

final class GetUserInfoFailed extends GetUserInfoState {
  final String message;

  GetUserInfoFailed(this.message);
  List<Object> get props => [message];
}
