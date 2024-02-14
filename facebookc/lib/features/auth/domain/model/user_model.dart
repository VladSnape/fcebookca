import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:facebookc/features/main/domain/models/post_model.dart';

class UserModel extends Equatable {
  final dynamic id;
  final String? name;
  final String? password;
  final String? bio;
  final String? avatarImage;

  final String? coverImage;

  final String? userName;
  final String? email;
  final List<UserModel>? friends;
  final List<UserModel>? waitFriends;
  final List? posts;

  const UserModel(
      {required this.id,
      this.avatarImage,
      this.coverImage,
      this.bio,
      this.name,
      this.password,
      this.userName,
      this.email,
      this.friends,
      this.waitFriends,
      this.posts});

  @override
  List<Object?> get props => [id];
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'password': password,
      'bio': bio,
      'avatarImage': avatarImage,
      'coverImage': coverImage,
      'userName': userName,
      'email': email,
      'friends': friends?.map((friend) => friend.toMap()).toList(),
      'waitFriends':
          waitFriends?.map((waitFriend) => waitFriend.toMap()).toList(),
      'posts': posts,
    };
  }

  static UserModel fromMap(Map<String, dynamic> userData) {
    return UserModel(
      avatarImage: userData['photoUrl'],
      coverImage: userData['coverUrl'],
      id: userData['id'],
      bio: userData['bio'],
      name: userData['name'],
      password: userData['password'],
      userName: userData['userName'],
      email: userData['email'],
      friends: (userData['friends'] as List<dynamic>?)
          ?.map((friendData) => UserModel.fromMap(friendData))
          .toList(),
      waitFriends: (userData['waitFriends'] as List<dynamic>?)
          ?.map((waitFriendData) => UserModel.fromMap(waitFriendData))
          .toList(),
      posts: (userData['posts'] as List),
    );
  }

  static List<PostModel> getPostModels(QuerySnapshot postSnap) {
    return postSnap.docs
        .map((postDoc) =>
            PostModel.fromMap(postDoc.data() as Map<String, dynamic>))
        .toList();
  }
}
