import 'package:dartz/dartz.dart';
import 'package:facebookc/core/app_failures.dart';
import 'package:facebookc/features/main/domain/repo/main_repo.dart';

import '../../../../auth/domain/model/user_model.dart';

class AddFriendUseCase {
  final MainRepo mainRepo;

  AddFriendUseCase(this.mainRepo);
  Future<Either<Failure, Unit>> call({
    required UserModel you,
    required String hisId,
  }) async {
    return await mainRepo.addFriend(you: you, hisId: hisId);
  }
}
