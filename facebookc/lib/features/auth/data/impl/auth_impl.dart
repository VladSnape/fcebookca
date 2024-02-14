import 'package:dartz/dartz.dart';
import 'package:facebookc/core/app_failures.dart';
import 'package:facebookc/features/auth/data/source/remote_datasource.dart';
import 'package:facebookc/features/auth/domain/model/user_model.dart';
import 'package:facebookc/features/auth/domain/repo/auth_repo.dart';

class AuthImpl implements AuthRepo {
  final AuthRemoteDatasource authRemoteDatasource;

  AuthImpl(this.authRemoteDatasource);
  @override
  Future<Either<Failure, UserModel>> getUser() async {
    try {
      UserModel result = await authRemoteDatasource.getUser();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> loginUserWithEmailandPassword(
      {required String email,
      required String password,
      String? name,
      String? userName}) async {
    try {
      await authRemoteDatasource.loginUserWithEmailandPassword(
          email: email, password: password);
      return Right(Unit as Unit);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> registerUserWithEmailAndPassword(
      {required String email,
      required String password,
      String? name,
      String? userName}) async {
    try {
      await authRemoteDatasource.registerUserWithEmailAndPassword(
          email: email, password: password);
      return Right(Unit as Unit);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
