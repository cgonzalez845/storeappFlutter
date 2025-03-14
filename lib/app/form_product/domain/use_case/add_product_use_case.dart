import 'package:dio/dio.dart';
import 'package:storeapp/app/core/data/remote/service/product_service.dart';
import 'package:storeapp/app/core/domain/entity/product_entity.dart';
import 'package:storeapp/app/form_product/data/repository/form_product_repository_impl.dart';
import 'package:storeapp/app/form_product/domain/repository/form_product_repository.dart';
import 'package:storeapp/app/form_product/presentation/model/product_form_model.dart';

class AddProductUseCase {
  late final FormProductRepository formProductRepository;
  late final ProductService _productService;
  AddProductUseCase({required this.formProductRepository});

 /* AddProductUseCase() {
    _productService = ProductService(dio: Dio());
    _formProductRepository = FormProductRepositoryImpl(
      productService: _productService,
    );
  }*/

  Future<bool> invoke(ProductFormModel productFormModel) {
    try {
      final ProductEntity data = productFormModel.toEntity();

      return formProductRepository.addProduct(data);
    } catch (e) {
      throw (Exception());
    }
  }
}
