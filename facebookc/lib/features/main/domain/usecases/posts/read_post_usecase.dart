import 'package:dartz/dartz.dart';
import 'package:facebookc/core/app_failures.dart';
import 'package:facebookc/features/main/domain/repo/main_repo.dart';

import '../../models/post_model.dart';

class ReadPostUseCase {
  final MainRepo mainRepo;

  ReadPostUseCase(this.mainRepo);
  Future<Either<Failure, PostModel>> call({required String postId}) async {
    final result = await mainRepo.readPost(postId: postId);
    return result;
  }
}
