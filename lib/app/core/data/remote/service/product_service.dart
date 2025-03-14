import 'package:dio/dio.dart';
import 'package:storeapp/app/core/data/remote/dto/product_data_model.dart';

final class ProductService {
  final Dio dio;
  final String _baseUrl =
      //"https://storeappdamo2024-default-rtdb.firebaseio.com";
      "https://storeappflu-default-rtdb.firebaseio.com";

  ProductService({required this.dio});

  Future<List<ProductDataModel>> getAll() async {
    final List<ProductDataModel> products = [];

    try {
      final Response response = await dio.get("$_baseUrl/products.json");
      print(response);

      if (response.data != null) {
        response.data.forEach((key, value) {
          products.add(ProductDataModel.fromJson(key, value));
        });
      }
    } catch (e) {
      throw Exception("Ha ocurrido un error obteniendo los datos: $e");
    }

    return products;
  }

  Future<ProductDataModel> get(String id) async {
    late final ProductDataModel productDataModel;
    try {
      final Response<Map<String, dynamic>> response = await dio.get(
        "$_baseUrl/products/$id.json",
      );
      if (response.data != null) {
        productDataModel = ProductDataModel.fromJson(id, response.data!);
      }
    } catch (e) {}
    return productDataModel;
  }

  Future<bool> add(ProductDataModel productDataModel) async {

    final Response response = await dio.get("$_baseUrl/products.json");
    print(response);
    print(productDataModel);
    print(productDataModel.toJson());
    //productDataModel.id = "aaaa2Wwds";
    try {
      await dio.post(
        "$_baseUrl/products.json",
        data: productDataModel.toJson(),
      );
      return true;
    } catch (e) {
      throw (Exception(e));
    }
    return false;
  }

  Future<bool> update(ProductDataModel productDataModel) async {
    try {
      await dio.put(
        "$_baseUrl/products/${productDataModel.id}.json",
        data: productDataModel.toJson(),
      );
      return true;
    } catch (e) {
      throw (Exception(e));
    }
    return false;
  }

  Future<bool> delete(String id) async {
    try {
      await dio.delete("$_baseUrl/products/$id.json");
      return true;
    } catch (e) {
      throw (Exception(e));
    }
    return false;
  }
}
