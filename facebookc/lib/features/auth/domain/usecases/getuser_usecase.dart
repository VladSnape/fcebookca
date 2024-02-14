import 'package:dartz/dartz.dart';
import 'package:facebookc/core/app_failures.dart';
import 'package:facebookc/features/auth/domain/model/user_model.dart';
import 'package:facebookc/features/auth/domain/repo/auth_repo.dart';

class GetUserUseCase {
  final AuthRepo authRepo;

  GetUserUseCase(this.authRepo);
  Future<Either<Failure, UserModel>> call() async {
    return await authRepo.getUser();
  }
}
