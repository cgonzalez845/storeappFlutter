import 'package:storeapp/app/core/data/remote/dto/product_data_model.dart';
import 'package:storeapp/app/core/data/remote/service/product_service.dart';
import 'package:storeapp/app/core/domain/entity/product_entity.dart';
import 'package:storeapp/app/form_product/domain/repository/form_product_repository.dart';

class FormProductRepositoryImpl implements FormProductRepository {
  final ProductService productService;

  FormProductRepositoryImpl({required this.productService});

  @override
  Future<bool> addProduct(ProductEntity productEntity) {
    print("repository");
    print(productEntity);
    try {
      return productService.add(productEntity.toProductDataModel());
    } catch (e) {
      throw (Exception());
    }
  }

  @override
  Future<ProductEntity> getProduct(String id) async {
    final ProductEntity productEntity;
    try {
      final response = await productService.get(id);
      return response.toEntity();
    } catch (e) {
      throw (Exception());
    }
  }

  @override
  Future<bool> updateProduct(ProductEntity productEntity) {
    try {
      return productService.update(productEntity.toProductDataModel());
    } catch (e) {
      throw (Exception());
    }
  }
}
