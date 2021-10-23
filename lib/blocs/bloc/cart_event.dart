part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class OnCartsChanged extends CartEvent {
  final List<Cart> carts;

  OnCartsChanged(this.carts);
}

class OnProductCartsChanged extends CartEvent {
  final List<ProductCart> productCarts;

  OnProductCartsChanged(this.productCarts);
}

class OnProductsChanged extends CartEvent {
  final List<Product> products;

  OnProductsChanged(this.products);
}
