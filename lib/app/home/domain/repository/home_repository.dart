import 'package:storeapp/app/core/data/remote/dto/product_data_model.dart';

abstract class HomeRepository {
  HomeRepository({required int id});

  Future<bool> deleteProduct(String id);

  //List<ProductEntity> getProducts();
  Future<List<ProductDataModel>> getProducts();
}
