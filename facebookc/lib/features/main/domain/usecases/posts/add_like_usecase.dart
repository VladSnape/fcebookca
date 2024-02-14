import 'package:dartz/dartz.dart';
import 'package:facebookc/core/app_failures.dart';
import 'package:facebookc/features/main/domain/models/like_model.dart';
import 'package:facebookc/features/main/domain/repo/main_repo.dart';

class AddLikeUseCase {
  final MainRepo mainRepo;

  AddLikeUseCase(this.mainRepo);
  Future<Either<Failure, Unit>> call(
      {required LikeModel likeModel, required String postId}) async {
    return await mainRepo.addLike(likeModel: likeModel, postId: postId);
  }
}
