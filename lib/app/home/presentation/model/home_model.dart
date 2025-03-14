import 'package:storeapp/app/core/domain/entity/product_entity.dart';
import 'package:storeapp/app/home/presentation/model/product_model.dart';

final class HomeModel {
  //final List<ProductEntity> product_entity;
  final List<ProductModel> products;

  HomeModel({required this.products});

  HomeModel copyWith({required List<ProductModel> products}) {
    return HomeModel(products: products);
  }
}
/**
 * final class LoginFormModel {
  final String email;
  final String password;

  LoginFormModel({required this.email, required this.password});

  LoginFormModel copyWith({String? email, String? password}) {
    return LoginFormModel(email: email ?? this.email, password: password ?? this.password);
  }

LoginEntity toEntity() => LoginEntity(email: email, password: password);
}
 */