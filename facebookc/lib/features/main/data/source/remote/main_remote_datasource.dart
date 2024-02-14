// ignore_for_file: empty_catches

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebookc/features/auth/domain/model/user_model.dart';
import 'package:facebookc/features/main/domain/models/comment_model.dart';
import 'package:facebookc/features/main/domain/models/like_model.dart';
import 'package:facebookc/features/main/domain/models/post_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class RemoteDataSource {
  // user
  // posts
  Future<void> addFriend({
    required UserModel you,
    required String hisId,
  });
  Future<void> cancelAddFriend({
    required UserModel you,
    required String hisId,
  });
  Future<void> deleteFriend({
    required String yourId,
    required UserModel him,
  });
  Future<void> acceptFriend({
    required UserModel him,
    required String yourId,
  });
  Future<void> cancelFriend({
    required UserModel him,
    required String yourId,
  });

  Future<List<PostModel>> getPosts({required dynamic userId});
  Future<PostModel> readPost({required String postId});

  Future<void> addPost({
    required PostModel postModel,
  });
  Future<void> registrePost({required PostModel postModel});
  Future<void> addLike({required LikeModel likeModel, required String postId});
  Future<void> addComment(
      {required CommentModel commentModel, required String postId});

  // profile
  Future<UserModel> getUserInfo({required String userId});

  Future<void> editProfile(
      {required String id,
      String? name,
      String? bio,
      String? userName,
      String? photoUrl,
      String? coverUrl});
}

class RemoteDataSourceIWFirebase implements RemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  RemoteDataSourceIWFirebase(this.firebaseAuth, this.firebaseFirestore);
  // posts

  @override
  Future<void> addPost({required PostModel postModel}) async {
    final userDocRef =
        firebaseFirestore.collection('users').doc(postModel.author);
    final postRef = firebaseFirestore.collection('posts').doc();

    await userDocRef.update({
      'posts':
          FieldValue.arrayUnion([postRef.id]), // Add post ID to the user's list
    });

    await postRef.set({
      'id': postRef.id,
      ...postModel.toMap(),
    });
  }

  @override
  Future<List<PostModel>> getPosts({required userId}) {
    // TODO: implement getPosts
    throw UnimplementedError();
  }

  @override
  Future<void> registrePost({required PostModel postModel}) {
    // TODO: implement registrePost
    throw UnimplementedError();
  }

  @override
  Future<void> editProfile({
    required String id,
    String? name,
    String? bio,
    String? userName,
    String? photoUrl,
    String? coverUrl,
  }) async {
    final Map<String, dynamic> dataToUpdate = {};

    if (name != null && name.isNotEmpty) {
      dataToUpdate['name'] = name;
    }

    if (bio != null && bio.isNotEmpty) {
      dataToUpdate['bio'] = bio;
    }

    if (userName != null && userName.isNotEmpty) {
      dataToUpdate['userName'] = userName;
    }

    if (photoUrl != null && photoUrl.isNotEmpty) {
      dataToUpdate['photoUrl'] = photoUrl;
    }

    if (coverUrl != null && coverUrl.isNotEmpty) {
      dataToUpdate['coverUrl'] = coverUrl;
    }

    await firebaseFirestore.collection('users').doc(id).update(dataToUpdate);
  }

  @override
  Future<void> addComment(
      {required CommentModel commentModel, required String postId}) async {
    try {
      await firebaseFirestore.collection('posts').doc(postId).update({
        'comments': FieldValue.arrayUnion([commentModel.toMap()]),
      });
    } catch (error) {}
  }

  @override
  Future<void> addLike(
      {required LikeModel likeModel, required String postId}) async {
    try {
      await firebaseFirestore.collection('posts').doc(postId).update({
        'likes': FieldValue.arrayUnion([likeModel.toMap()]),
      });
    } catch (error) {
      // Handle the error as needed
    }
  }

  @override
  Future<PostModel> readPost({required String postId}) async {
    try {
      DocumentSnapshot postSnapshot =
          await firebaseFirestore.collection('posts').doc(postId).get();

      if (postSnapshot.exists) {
        Map<String, dynamic> postData =
            postSnapshot.data() as Map<String, dynamic>;

        // Assuming you have a static method in your PostModel class to create an instance from a map
        PostModel post = PostModel.fromMap(postData);

        return post;
      } else {
        // Handle the case where the post does not exist
        throw Exception('Post not found');
      }
    } catch (error) {
      // Handle the error as needed
      throw Exception('Failed to read post');
    }
  }

  @override
  Future<UserModel> getUserInfo({required String userId}) async {
    try {
      DocumentSnapshot userSnapshot =
          await firebaseFirestore.collection("users").doc(userId).get();

      if (userSnapshot.exists) {
        // If the document exists, convert the data to a UserModel
        Map<String, dynamic>? userData =
            userSnapshot.data() as Map<String, dynamic>?;

        if (userData != null) {
          UserModel user = UserModel.fromMap(userData);
          return user;
        } else {
          // Handle the case where the data is null
          throw Exception("User data is null");
        }
      } else {
        // Handle the case where the document does not exist
        throw Exception("User document does not exist");
      }
    } catch (e) {
      // Handle any errors that might occur during the asynchronous operations

      throw Exception("Failed to fetch user data");
    }
  }

  @override
  Future<void> acceptFriend({required UserModel him, required String yourId}) {
    // TODO: implement acceptFriend
    throw UnimplementedError();
  }

  @override
  Future<void> addFriend(
      {required UserModel you, required String hisId}) async {
    try {
      // Get a reference to the user document
      DocumentReference userDocRef =
          firebaseFirestore.collection('user').doc(hisId);

      // Create a Friend object
      FriendModel newFriend = FriendModel(
        userName: you.userName,
        id: you.id,
        avatarImage: you.avatarImage,
      );

      // Update the waitFriends field with the new friend's information
      await userDocRef.update({
        'waitFriends': FieldValue.arrayUnion([newFriend.toMap()]),
      });
    } catch (e) {
      // Handle the error as needed
    }
  }

  @override
  Future<void> cancelAddFriend(
      {required UserModel you, required String hisId}) async {
    try {
      // Get a reference to the user document
      DocumentReference userDocRef =
          firebaseFirestore.collection('user').doc(hisId);

      FriendModel newFriend = FriendModel(
        userName: you.userName,
        id: you.id,
        avatarImage: you.avatarImage,
      );

      // Remove the current user from the waitFriends field
      await userDocRef.update({
        'waitFriends': FieldValue.arrayRemove([newFriend.toMap()]),
      });
    } catch (e) {
      // Handle the error as needed
    }
  }

  @override
  Future<void> cancelFriend({required UserModel him, required String yourId}) {
    // TODO: implement cancelFriend
    throw UnimplementedError();
  }

  @override
  Future<void> deleteFriend({required String yourId, required UserModel him}) {
    // TODO: implement deleteFriend
    throw UnimplementedError();
  }
}

class FriendModel {
  final String? userName;
  final String id;
  final String? avatarImage;

  FriendModel({
    this.userName,
    required this.id,
    this.avatarImage,
  });

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'id': id,
      'avatarImage': avatarImage,
    };
  }

  static FriendModel fromMap(Map<String, dynamic> map) {
    return FriendModel(
      userName: map['userName'],
      id: map['id'],
      avatarImage: map['avatarImage'],
    );
  }
}
