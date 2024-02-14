import 'package:equatable/equatable.dart';
import 'package:facebookc/features/auth/domain/model/user_model.dart';

class GroupModel extends Equatable {
  final dynamic id;

  final String name;
  final List<UserModel>? members;

  const GroupModel({required this.id, required this.name, this.members});

  @override
  List<Object?> get props => [id];
}
