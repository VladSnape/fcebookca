import 'package:dartz/dartz.dart';
import 'package:facebookc/core/app_failures.dart';
import 'package:facebookc/features/auth/domain/model/user_model.dart';
import 'package:facebookc/features/main/domain/repo/main_repo.dart';

class GetUserInfoUseCase {
  final MainRepo mainRepo;

  GetUserInfoUseCase(this.mainRepo);
  Future<Either<Failure, UserModel>> call({required String userId}) async {
    return await mainRepo.getUserInfo(userId: userId);
  }
}
