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

class OnNumberOfProductsInActiveCartChanged extends CartEvent {
  final int numberOfProductsInActiveCart;

  OnNumberOfProductsInActiveCartChanged(this.numberOfProductsInActiveCart);
}

class OnActiveCartChanged extends CartEvent {
  final Cart activeCart;

  OnActiveCartChanged(this.activeCart);
}
class OnProductsInActiveCartChanged extends CartEvent {
  final List<Product> productsInActiveCart;

  OnProductsInActiveCartChanged(this.productsInActiveCart);

}
