import 'package:dartz/dartz.dart';
import 'package:facebookc/core/app_failures.dart';
import 'package:facebookc/features/main/domain/models/post_model.dart';
import 'package:facebookc/features/main/domain/repo/main_repo.dart';

class GetPostsUseCase {
  final MainRepo mainRepo;

  GetPostsUseCase(this.mainRepo);
  Future<Either<Failure, List<PostModel>>> call(
      {required dynamic userId}) async {
    return await mainRepo.getPosts(userId: userId);
  }
}
