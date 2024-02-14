part of 'add_like_comment_cubit.dart';

sealed class AddLikeCommentState extends Equatable {
  const AddLikeCommentState();

  @override
  List<Object> get props => [];
}

final class AddLikeCommentInitial extends AddLikeCommentState {}

final class AddLikeCommentloading extends AddLikeCommentState {}

final class AddLikeCommentfailure extends AddLikeCommentState {
  final String message;

  const AddLikeCommentfailure(this.message);
}

final class AddLikeCommentsuccess extends AddLikeCommentState {}
