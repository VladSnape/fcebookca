import 'package:dartz/dartz.dart';
import 'package:facebookc/core/app_failures.dart';
import 'package:facebookc/features/auth/domain/model/user_model.dart';
import 'package:facebookc/features/main/domain/models/comment_model.dart';
import 'package:facebookc/features/main/domain/models/like_model.dart';
import 'package:facebookc/features/main/domain/models/post_model.dart';

abstract class MainRepo {
  // posts
  Future<Either<Failure, List<PostModel>>> getPosts({required dynamic userId});

  Future<Either<Failure, PostModel>> readPost({required String postId});

  Future<Either<Failure, Unit>> addPost({
    required PostModel postModel,
  });
  Future<Either<Failure, Unit>> registrePost({required PostModel postModel});

  // friend
  Future<Either<Failure, Unit>> addFriend({
    required UserModel you,
    required String hisId,
  });
  Future<Either<Failure, Unit>> cancelAddFriend({
    required UserModel you,
    required String hisId,
  });
  Future<Either<Failure, Unit>> deleteFriend({
    required String yourId,
    required UserModel him,
  });
  Future<Either<Failure, Unit>> acceptFriend({
    required UserModel him,
    required String yourId,
  });
  Future<Either<Failure, Unit>> cancelFriend({
    required UserModel him,
    required String yourId,
  });

  // comments
  Future<Either<Failure, Unit>> addComment(
      {required CommentModel commentModel, required String postId});
  Future<Either<Failure, List<CommentModel>>> readComments();

  // likes
  Future<Either<Failure, Unit>> addLike(
      {required LikeModel likeModel, required String postId});

  // profile
  Future<Either<Failure, UserModel>> getUserInfo({required String userId});

  Future<Either<Failure, Unit>> editProfile(
      {required String id,
      String? name,
      String? bio,
      String? userName,
      String? photoUrl,
      String? coverUrl});
}
