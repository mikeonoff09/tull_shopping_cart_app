import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/bloc/cart_bloc.dart';
import 'border_icon.dart';

class CartIconButton extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const CartIconButton({
    Key key,
  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return Stack(
          children: <Widget>[
            const BorderIcon(
              child: Icon(Icons.shopping_cart),
              height: 50,
              width: 50,
            ),
            Positioned(
              top: 1,
              right: 2,
              child: CircleAvatar(
                backgroundColor: Colors.red[700],
                maxRadius: 11,
                child: Text(
                  state.numberOfProductsInActiveCart.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
