import 'package:equatable/equatable.dart';
import 'package:facebookc/features/main/domain/models/item_model.dart';

class CollectionModel extends Equatable {
  final dynamic id;

  final String name;
  final List<ItemModel>? items;

  const CollectionModel({required this.id, required this.name, this.items});

  @override
  List<Object?> get props => [id];
}
