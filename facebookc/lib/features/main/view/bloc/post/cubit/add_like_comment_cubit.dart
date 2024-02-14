// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:facebookc/features/main/domain/models/comment_model.dart';
import 'package:facebookc/features/main/domain/models/like_model.dart';
import 'package:facebookc/features/main/domain/usecases/posts/add_comment_usecase.dart';
import 'package:facebookc/features/main/domain/usecases/posts/add_like_usecase.dart';

part 'add_like_comment_state.dart';

class AddLikeCommentCubit extends Cubit<AddLikeCommentState> {
  final AddCommentUseCase addCommentUseCase;
  final AddLikeUseCase addLikeUseCase;
  AddLikeCommentCubit(this.addCommentUseCase, this.addLikeUseCase)
      : super(AddLikeCommentInitial());

  addLike({required LikeModel likeModel, required String postId}) async {
    emit(AddLikeCommentloading());

    final result =
        await addLikeUseCase.call(likeModel: likeModel, postId: postId);
    result.fold((l) {
      emit(AddLikeCommentfailure(l.message));
    }, (r) {
      emit(AddLikeCommentsuccess());
    });
  }

  addComment(
      {required CommentModel commentModel, required String postId}) async {
    emit(AddLikeCommentloading());
    final result = await addCommentUseCase.call(
        commentModel: commentModel, postId: postId);
    result.fold((l) {
      emit(AddLikeCommentfailure(l.message));
    }, (r) {
      emit(AddLikeCommentsuccess());
    });
  }
}
