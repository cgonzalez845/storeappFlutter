import 'package:storeapp/app/core/data/remote/dto/product_data_model.dart';
import 'package:storeapp/app/home/domain/repository/home_repository.dart';
import 'package:storeapp/app/home/presentation/model/product_model.dart';

class GetProductsUseCase {
  final HomeRepository homeRepository;

  GetProductsUseCase({required this.homeRepository});

  Future<List<ProductModel>> invoke() async {
    final List<ProductModel> products = [];
    try {
      final List<ProductDataModel> data = await homeRepository.getProducts();
      for (var element in data) {
        products.add(element.toModel());
      }
      return products;
    } catch (e) {
      throw Exception(e);
    }
  }
  //GetProductsUseCase();
}
