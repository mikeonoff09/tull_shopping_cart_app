part of 'cart_bloc.dart';

class CartState {
  final Cart activeCart;
  final List<Cart> carts;//
  final List<Product> products;//
  final List<ProductCart> productCarts;//
  // final List<Product> productsInActiveCart;
  // final int numberOfProductsInActiveCart;
  final List<ProductCart> activeCartProductCarts;
  final double total;

  CartState({
    carts,
    total,
    products,
    activeCart,
    productCarts,
    productsInActiveCart,
    activeCartProductCarts,
    numberOfProductsInActiveCart,
  })  : total = total ?? 0,
        carts = carts ?? <Cart>[],
        products = products ?? <Product>[],
        activeCart = activeCart ?? Cart(),
        productCarts = productCarts ?? <ProductCart>[],
        // productsInActiveCart = productsInActiveCart ?? <Product>[],
        activeCartProductCarts = activeCartProductCarts ?? <ProductCart>[]
        // numberOfProductsInActiveCart = numberOfProductsInActiveCart ?? 0
        ;

  CartState copyWith({
    double total,
    Cart activeCart,
    List<Cart> carts,
    List<Product> products,
    int numberOfProductsInActiveCart,
    List<ProductCart> productCarts,
    List<ProductCart> activeCartProductCarts,
    // final List<Product> productsInActiveCart,
  }) =>
      CartState(
        activeCartProductCarts: activeCartProductCarts ?? this.activeCartProductCarts,
        total: total ?? this.total,
        carts: carts ?? this.carts,
        products: products ?? this.products,
        activeCart: activeCart ?? this.activeCart,
        productCarts: productCarts ?? this.productCarts,
        // productsInActiveCart: productsInActiveCart ?? this.productsInActiveCart,
        // numberOfProductsInActiveCart:
        //     numberOfProductsInActiveCart ?? this.numberOfProductsInActiveCart,
      );
}
