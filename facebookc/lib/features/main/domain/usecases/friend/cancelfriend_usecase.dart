import 'package:dartz/dartz.dart';
import 'package:facebookc/features/main/domain/repo/main_repo.dart';

import '../../../../../core/app_failures.dart';
import '../../../../auth/domain/model/user_model.dart';

class CancelAddFriendUseCase {
  final MainRepo mainRepo;

  CancelAddFriendUseCase(this.mainRepo);
  Future<Either<Failure, Unit>> call({
    required UserModel you,
    required String hisId,
  }) async {
    return await mainRepo.cancelAddFriend(you: you, hisId: hisId);
  }
}
