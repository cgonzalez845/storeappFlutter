import 'package:storeapp/app/core/domain/entity/product_entity.dart';
import 'package:storeapp/app/home/presentation/model/product_model.dart';

class ProductDataModel {
  final String id;
  late final String name;
  late final double price;
  late final String imageUrl;

  ProductDataModel({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  ProductDataModel.fromJson(String this.id, Map<String, dynamic> json) {
    name = json["name"];
    price = json["price"];
    imageUrl = json["image"];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{"name": name, "price": price, "image": imageUrl};
  }

  ProductEntity toEntity() {
    return ProductEntity(id: id, name: name, image: imageUrl, price: price);
  }

  ProductModel toModel() {
    return ProductModel(id: id, name: name, urlImage: imageUrl, price: price);
  }
}
