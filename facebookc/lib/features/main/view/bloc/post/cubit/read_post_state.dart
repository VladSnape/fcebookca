part of 'read_post_cubit.dart';

sealed class ReadPostState extends Equatable {
  const ReadPostState();

  @override
  List<Object> get props => [];
}

final class ReadPostInitial extends ReadPostState {}

final class ReadPostLoading extends ReadPostState {}

final class ReadPostFailed extends ReadPostState {
  final String message;

  const ReadPostFailed(this.message);
}

final class ReadPostSuccess extends ReadPostState {
  final PostModel postModel;

  const ReadPostSuccess(this.postModel);
  @override
  List<Object> get props => [postModel];
}
