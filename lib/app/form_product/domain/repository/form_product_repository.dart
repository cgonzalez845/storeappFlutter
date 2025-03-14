import 'package:storeapp/app/core/domain/entity/product_entity.dart';
import 'package:storeapp/app/login/domain/entity/login_entity.dart';

abstract class FormProductRepository {

  Future<bool> addProduct(ProductEntity productEntity);

  Future<ProductEntity> getProduct(String id);

  Future<bool> updateProduct(ProductEntity productEntity);
  
}