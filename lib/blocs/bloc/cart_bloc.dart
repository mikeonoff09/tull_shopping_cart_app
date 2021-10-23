import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tull_shopping_cart_app/models/cart_model.dart';
import 'package:tull_shopping_cart_app/models/product_cart_model.dart';
import 'package:tull_shopping_cart_app/models/producto_model.dart';

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
    } else if (event is OnProductCartsChanged) {
      yield state.copyWith(productCarts: event.productCarts);
    }
  }
}
