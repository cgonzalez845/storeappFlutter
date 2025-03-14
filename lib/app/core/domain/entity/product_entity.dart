
import 'package:storeapp/app/core/data/remote/dto/product_data_model.dart';

final class ProductEntity {
  final String id;
  final String name;
  final String image;
  final double price;

  ProductEntity(
      {required this.id,
      required this.name,
      required this.image,
      required this.price});

/*ProductModel toProductModel() {
    return ProductModel(id: id, name: name, imageUrl: imageUrl, price: price);
  }*/

  ProductDataModel toProductDataModel() {
    return ProductDataModel(id: id, name: name, price: price, imageUrl: image);
  }
}