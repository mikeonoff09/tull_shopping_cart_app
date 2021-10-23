part of 'cart_bloc.dart';

class CartState {
  final List<Cart> carts;
  final List<ProductCart> productCarts;
  final List<Product> products;

  CartState({
    carts,
    productCarts,
    products,
  })  : carts = carts ?? <Cart>[],
        products = products ?? <Product>[],
        productCarts = productCarts ?? <ProductCart>[];

  CartState copyWith({
    List<Cart> carts,
    List<ProductCart> productCarts,
  }) =>
      CartState(
        carts: carts ?? this.carts,
        productCarts: productCarts ?? this.productCarts,
      );
}
