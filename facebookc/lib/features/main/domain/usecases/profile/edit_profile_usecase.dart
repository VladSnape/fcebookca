import 'package:dartz/dartz.dart';
import 'package:facebookc/core/app_failures.dart';
import 'package:facebookc/features/main/domain/repo/main_repo.dart';

class EditProfileUseCase {
  final MainRepo mainRepo;

  EditProfileUseCase(this.mainRepo);

  Future<Either<Failure, Unit>> call(
      {required String id,
      String? name,
      String? bio,
      String? userName,
      String? photoUrl,
      String? coverUrl}) async {
    final result = await mainRepo.editProfile(
        id: id,
        name: name,
        bio: bio,
        userName: userName,
        photoUrl: photoUrl,
        coverUrl: coverUrl);
    return result;
  }
}
