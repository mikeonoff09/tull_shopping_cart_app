part of 'cart_bloc.dart';

class CartState {
  final Cart activeCart;
  final List<Cart> carts;
  final List<Product> products;
  final List<ProductCart> productCarts;
  final List<ProductCart> activeCartProductCarts;
  final int numberOfProductsInActiveCart;
  final double total;

  CartState({
    carts,
    total,
    products,
    activeCart,
    productCarts,
    activeCartProductCarts,
    numberOfProductsInActiveCart,
  })  : total = total ?? 0,
        carts = carts ?? <Cart>[],
        products = products ?? <Product>[],
        activeCart = activeCart ?? Cart(),
        productCarts = productCarts ?? <ProductCart>[],
        activeCartProductCarts = activeCartProductCarts ?? <ProductCart>[],
        numberOfProductsInActiveCart = numberOfProductsInActiveCart ?? 0;

  CartState copyWith({
    double total,
    Cart activeCart,
    List<Cart> carts,
    List<Product> products,
    int numberOfProductsInActiveCart,
    List<ProductCart> productCarts,
    final List<Product> activeCartProductCarts,
  }) =>
      CartState(
        total: total ?? this.total,
        carts: carts ?? this.carts,
        products: products ?? this.products,
        activeCart: activeCart ?? this.activeCart,
        productCarts: productCarts ?? this.productCarts,
        activeCartProductCarts:
            activeCartProductCarts ?? this.activeCartProductCarts,
        numberOfProductsInActiveCart:
            numberOfProductsInActiveCart ?? this.numberOfProductsInActiveCart,
      );
}
