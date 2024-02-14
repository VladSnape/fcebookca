import 'package:dartz/dartz.dart';
import 'package:facebookc/core/app_failures.dart';
import 'package:facebookc/features/auth/domain/model/user_model.dart';
import 'package:facebookc/features/main/data/source/remote/main_remote_datasource.dart';
import 'package:facebookc/features/main/domain/models/comment_model.dart';
import 'package:facebookc/features/main/domain/models/like_model.dart';
import 'package:facebookc/features/main/domain/models/post_model.dart';
import 'package:facebookc/features/main/domain/repo/main_repo.dart';

class MainImpl implements MainRepo {
  final RemoteDataSource remoteDataSource;

  MainImpl(this.remoteDataSource);
  @override
  Future<Either<Failure, Unit>> acceptFriend({
    required UserModel him,
    required String yourId,
  }) {
    // TODO: implement acceptFriend
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> addComment(
      {required CommentModel commentModel, required String postId}) async {
    try {
      await remoteDataSource.addComment(
          commentModel: commentModel, postId: postId);
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> addFriend({
    required UserModel you,
    required String hisId,
  }) async {
    try {
      await remoteDataSource.addFriend(you: you, hisId: hisId);
      return Right(Unit as Unit);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> addLike(
      {required LikeModel likeModel, required String postId}) async {
    try {
      await remoteDataSource.addLike(likeModel: likeModel, postId: postId);
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost({required PostModel postModel}) async {
    try {
      await remoteDataSource.addPost(postModel: postModel);
      return Right(Unit as Unit);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> cancelAddFriend({
    required UserModel you,
    required String hisId,
  }) async {
    try {
      await remoteDataSource.cancelAddFriend(you: you, hisId: hisId);
      return Right(Unit as Unit);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> cancelFriend({
    required UserModel him,
    required String yourId,
  }) {
    // TODO: implement cancelFriend
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<CommentModel>>> readComments() {
    // TODO: implement readComments
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> registrePost({required PostModel postModel}) {
    // TODO: implement registrePost
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> editProfile(
      {required String id,
      String? name,
      String? bio,
      String? userName,
      String? photoUrl,
      String? coverUrl}) async {
    try {
      await remoteDataSource.editProfile(
          bio: bio,
          id: id,
          name: name,
          userName: userName,
          photoUrl: photoUrl,
          coverUrl: coverUrl);
      return Right(Unit as Unit);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PostModel>> readPost({required String postId}) async {
    try {
      PostModel postModel = await remoteDataSource.readPost(postId: postId);
      return Right(postModel);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getUserInfo(
      {required String userId}) async {
    try {
      final UserModel result =
          await remoteDataSource.getUserInfo(userId: userId);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteFriend(
      {required String yourId, required UserModel him}) {
    // TODO: implement deleteFriend
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<PostModel>>> getPosts({required userId}) {
    // TODO: implement getPosts
    throw UnimplementedError();
  }
}
