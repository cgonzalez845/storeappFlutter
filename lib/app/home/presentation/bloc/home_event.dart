import 'package:storeapp/app/core/domain/entity/product_entity.dart';

sealed class HomeEvent {}

final class LogOutEvent extends HomeEvent {
  LogOutEvent();
}

final class GetProductsEvent extends HomeEvent {
  GetProductsEvent();
}

final class DeleteProductsEvent extends HomeEvent {
  final String id;
  DeleteProductsEvent({required this.id});
}

final class ProductChangedEvent extends HomeEvent {
  final List<ProductEntity> products;
  ProductChangedEvent({required this.products});
}
