import 'package:dartz/dartz.dart';
import 'package:facebookc/core/app_failures.dart';
import 'package:facebookc/features/main/domain/models/post_model.dart';
import 'package:facebookc/features/main/domain/repo/main_repo.dart';

class RegistrePostUseCase {
  final MainRepo mainRepo;

  RegistrePostUseCase(this.mainRepo);
  Future<Either<Failure, Unit>> call({required PostModel postModel}) async {
    return await mainRepo.registrePost(postModel: postModel);
  }
}
