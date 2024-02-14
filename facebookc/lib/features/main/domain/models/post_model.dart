import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebookc/features/main/domain/models/comment_model.dart';
import 'package:facebookc/features/main/domain/models/item_model.dart';
import 'package:facebookc/features/main/domain/models/like_model.dart';

class PostModel extends ItemModel {
  const PostModel({
    required String author,
    required String text,
    this.authorAvatar,
    this.authorUserName,
    String? id,
    List<CommentModel>? comments,
    String? image,
    List<LikeModel>? likes,
    Timestamp? timeStamp,
  }) : super(
          author: author,
          text: text,
          id: id,
          comments: comments,
          image: image,
          likes: likes,
          timestamp: timeStamp,
        );

  final String? authorAvatar;
  final String? authorUserName;

  Map<String, dynamic> toMap() {
    return {
      'timeStamp': timestamp,
      'author': author, // Assuming UserModel has a toMap method
      'text': text,
      'comments': comments?.map((comment) => comment.toMap()).toList(),
      'image': image,
      'likes': likes?.map((like) => like.toMap()).toList(),
      'authorAvatar': authorAvatar,
      'authorUserName': authorUserName,
    };
  }

  static PostModel fromMap(Map<String, dynamic> postData) {
    return PostModel(
      timeStamp: postData['timeStamp'],
      author: postData['author'],
      text: postData['text'],
      id: postData['id'],
      comments: (postData['comments'] as List<dynamic>?)
          ?.map((commentData) => CommentModel.fromMap(commentData))
          .toList(),
      image: postData['image'],
      likes: (postData['likes'] as List<dynamic>?)
          ?.map((likeData) => LikeModel.fromMap(likeData))
          .toList(),
      authorAvatar: postData['authorAvatar'],
      authorUserName: postData['authorUserName'],
    );
  }

  @override
  List<Object?> get props =>
      [id, comments, likes, authorAvatar, authorUserName];
}
