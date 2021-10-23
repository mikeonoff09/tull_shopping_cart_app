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
    } else if (event is OnNumberOfProductsInActiveCartChanged) {
      yield state.copyWith(
          numberOfProductsInActiveCart: event.numberOfProductsInActiveCart);
    } else if (event is OnActiveCartChanged) {
      yield state.copyWith(activeCart: event.activeCart);
    }
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

  void editQuantity(int productId, int quantity){

  }

  void removeCartItemFromCart(int productId){
    
  }
}
