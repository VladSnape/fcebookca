import 'package:dartz/dartz.dart';
import 'package:facebookc/core/app_failures.dart';
import 'package:facebookc/features/auth/domain/model/user_model.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserModel>> getUser();
  Future<Either<Failure, Unit>> registerUserWithEmailAndPassword(
      {required String email,
      required String password,
      String? name,
      String? userName});
  Future<Either<Failure, Unit>> loginUserWithEmailandPassword(
      {required String email,
      required String password,
      String? name,
      String? userName});
}
