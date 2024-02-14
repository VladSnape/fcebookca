part of 'add_cancel_friend_cubit.dart';

sealed class AddCancelFriendState extends Equatable {
  const AddCancelFriendState();

  @override
  List<Object> get props => [];
}

final class AddCancelFriendNotFried extends AddCancelFriendState {
  final bool isFriend = false;
  final bool isAdded = false;
  final bool isWaitingToAcceptMe = false;
  final bool isWaitingToAcceptHim = false;
}

final class AddCancelFriendWaitingToAcceptMe extends AddCancelFriendState {
  final bool isAdded = true;
  final bool isWaitingToAcceptMe = true;
  final bool isWaitingToAcceptHim = false;
  final bool isFriend = false;
}

final class AddCancelFriendWaitingToAcceptHim extends AddCancelFriendState {
  final bool isAdded = true;
  final bool isWaitingToAcceptMe = false;
  final bool isWaitingToAcceptHim = true;
  final bool isFriend = false;
}

final class AddCancelFriendFriend extends AddCancelFriendState {
  final bool isFriend = true;
}

final class AddCancelFriendLoading extends AddCancelFriendState {}

final class AddCancelFriendFailed extends AddCancelFriendState {
  final bool isAdded = false;
  final String message;

  const AddCancelFriendFailed(this.message);
}
