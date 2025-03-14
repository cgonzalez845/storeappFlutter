import 'package:storeapp/app/core/data/remote/dto/product_data_model.dart';
import 'package:storeapp/app/core/data/remote/service/product_service.dart';
import 'package:storeapp/app/home/domain/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final ProductService productService;

  HomeRepositoryImpl({required this.productService});

  @override
  Future<bool> deleteProduct(String id) async {
    // TODO: implement deleteProduct
    return productService.delete(id);
  }

  @override
  Future<List<ProductDataModel>> getProducts() async {
    // TODO: implement getProducts
    final List<ProductDataModel> products = [];
    try {
      final response = await productService.getAll();
      for (var element in response) {
        products.add(element);
      }
    } catch (e) {
      throw (Exception(e));
    }

    return products;
  }
}
