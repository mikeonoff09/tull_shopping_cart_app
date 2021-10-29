import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/cart_model.dart';
import '../../models/product_cart_model.dart';
import '../../models/producto_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState());
  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is OnCartsChanged) {
      yield state.copyWith(carts: event.carts);
    } else if (event is OnProductCartsChanged) {
      yield state.copyWith(productCarts: event.productCarts);
    } else if (event is OnProductsChanged) {
      yield state.copyWith(products: event.products);
    } else if (event is OnActiveCartProductCartsChanged) {
      yield state.copyWith(
          activeCartProductCarts: event.activeCartProductCarts);
    } else if (event is OnActiveCartChanged) {
      yield state.copyWith(activeCart: event.activeCart);
    } else if (event is OnTotalChanged) {
      yield state.copyWith(total: event.total);
    }
  }

  cartsManager(List<Cart> carts) {
    // print(carts)
    if (carts != null) {
      for (var i = carts.length - 1; i > 0; i--) {
        // es mas probable que el carrito "pending" est'e al final
        if (carts[i]?.status == "pending") {
          add(OnActiveCartChanged(carts[i]));
          break;
        }
      }
      add(OnCartsChanged(carts));
    }
  }

  productsManager(List<Product> products) {
    add(OnProductsChanged(products));
  }

  productCartsManager(List<ProductCart> productCarts) {
    List<ProductCart> activeProductCarts = <ProductCart>[];
    for (var item in productCarts) {
      if (item.cartId == state.activeCart?.id ?? 0) {
        activeProductCarts.add(item);
      }
    }
    add(OnActiveCartProductCartsChanged(activeProductCarts));
    add(OnProductCartsChanged(productCarts));
  }

  computeTotal() {
    List<ProductCart> prodCart = state.activeCartProductCarts;
    List<Product> prods = state.products;
    double total = 0;
    for (var item in prodCart) {
      int cantidad = item.quantity;
      double precio =
          prods.firstWhere((element) => element.id == item.productId).price;
      total += cantidad * precio;
    }
    add(OnTotalChanged(total));
  }

  Product findProductById(int productId) {
    Product product = Product();
    for (var item in state.products) {
      if (item.id == productId) {
        product = item;
        break;
      }
    }
    return product;
  }

  void editQuantity(int productId, int quantity) {
    List<ProductCart> productCarts = state.activeCartProductCarts;

    int index =
        productCarts.indexWhere((element) => element.productId == productId);
    if (index >= 0) {
      productCarts[index].quantity = quantity;
      add(OnActiveCartProductCartsChanged(productCarts));
      // TODO: guardar en firebase
    }
    computeTotal();
  }

  void removeCartItemFromCart(int productId) {
    List<ProductCart> productCarts = state.activeCartProductCarts;

    int index =
        productCarts.indexWhere((element) => element.productId == productId);
    if (index >= 0) {
      productCarts.removeAt(index);
    }
    add(OnActiveCartProductCartsChanged(productCarts));
    // TODO: eliminar de firebase
    computeTotal();
  }

  int addItemToCart(int productId) {
    try {
      List<ProductCart> productCarts = state.productCarts;
      List<ProductCart> activeCartProductCarts = state.activeCartProductCarts;
      bool isOnCart = false;
      for (var item in state.activeCartProductCarts) {
        if (item.id == productId) {
          isOnCart = true;
          break;
        }
      }
      if (!isOnCart) {
        ProductCart pCart = ProductCart(
          cartId: state.activeCart.id,
          productId: productId,
          quantity: 1,
        );
        productCarts.add(pCart);
        activeCartProductCarts.add(pCart);
        add(OnProductCartsChanged(productCarts));
        add(OnActiveCartProductCartsChanged(activeCartProductCarts));
        // TODO: guardar en firebase
        computeTotal();
        return 1; // se guardo
      }
      return 0; // no se guardo porque ya esta en lista
    } catch (e) {
      return -1; // error al guardar en base de datos
    }
  }
}
