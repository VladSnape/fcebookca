import 'package:dartz/dartz.dart';
import 'package:facebookc/core/app_failures.dart';
import 'package:facebookc/features/auth/domain/repo/auth_repo.dart';

class LoginUserUseCase {
  final AuthRepo authRepo;

  LoginUserUseCase(this.authRepo);
  Future<Either<Failure, Unit>> call(
      {required String email,
      required String password,
      String? name,
      String? userName}) async {
    return await authRepo.loginUserWithEmailandPassword(
        email: email, password: password, userName: userName, name: name);
  }
}
