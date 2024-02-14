import 'package:dartz/dartz.dart';
import 'package:facebookc/features/main/domain/models/comment_model.dart';
import 'package:facebookc/features/main/domain/repo/main_repo.dart';

import '../../../../../core/app_failures.dart';

class AddCommentUseCase {
  final MainRepo mainRepo;

  AddCommentUseCase(this.mainRepo);
  Future<Either<Failure, Unit>> call(
      {required CommentModel commentModel, required String postId}) async {
    return await mainRepo.addComment(
        commentModel: commentModel, postId: postId);
  }
}
