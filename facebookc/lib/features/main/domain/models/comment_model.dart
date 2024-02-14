import 'package:equatable/equatable.dart';

class CommentModel extends Equatable {
  final dynamic id;
  final String text;
  final String authorUserName;
  final String? avatar;
  final String userId;

  CommentModel(
      {this.id,
      required this.text,
      required this.authorUserName,
      this.avatar,
      required this.userId});

  @override
  List<Object?> get props => [id, text];
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'authorUserName': authorUserName,
      'avatar': avatar,
      'userId': userId
    };
  }

  static CommentModel fromMap(Map<String, dynamic> commentData) {
    return CommentModel(
        userId: commentData['userId'],
        id: commentData['id'],
        text: commentData['text'],
        authorUserName: commentData['authorUserName'],
        avatar: commentData['avatar']);
  }
}
