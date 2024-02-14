import 'package:facebookc/features/main/domain/models/item_model.dart';

class ProductModel extends ItemModel {
  final double price;

  const ProductModel({
    required String author,
    required String text,
    required int id,
    required this.price,
    super.comments,
    super.image,
    super.likes,
  }) : super(
          author: author,
          text: text,
          id: id,
        );
}
