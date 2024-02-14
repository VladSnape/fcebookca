import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:facebookc/features/main/domain/models/comment_model.dart';
import 'package:facebookc/features/main/domain/models/like_model.dart';

class ItemModel extends Equatable {
  final dynamic id;
  final String author;
  final String text;
  final String? image;
  final List<CommentModel>? comments;
  final List<LikeModel>? likes;
  final Timestamp? timestamp;

  const ItemModel(
      {required this.author,
      required this.text,
      this.timestamp,
      this.image,
      this.comments,
      this.likes,
      required this.id,
      String? authorAvatar,
      String? authorUserName});

  @override
  List<Object?> get props => [id];
}
