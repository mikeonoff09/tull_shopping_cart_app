import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tull_shopping_cart_app/blocs/bloc/cart_bloc.dart';
import 'package:tull_shopping_cart_app/widgets/item_carrito_widget.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: _CartList(),
              ),
            ),
            _total(),
            _procederAlPago(context),
          ],
        ),
      ),
    );
  }
}

Widget _procederAlPago(BuildContext context) {
  return BlocBuilder<CartBloc, CartState>(
    builder: (context, state) {
      return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        child: const Text('Proceder al Pago'),
        onPressed: () {
            if (state.total > 0) {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => PaymentOption()),
              // );
            } else {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Agregue productos al carrito')));
            }
        },
        
      ),
    );
    },
  );
}

Widget _total() {
  return BlocBuilder<CartBloc, CartState>(
    builder: (context, state) {
      return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Total: \$  ${state.total.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.headline5,
          ),
        );
    },
  );
}

showFullAlertDialog(BuildContext context,
    {@required String title,
    @required String mensaje,
    @required Function funcionAceptar,
    @required Function funcionCancelar}) {
  // set up the button
  Widget okButton = TextButton(
    child: const Text("Aceptar"),
    onPressed: funcionAceptar,
  );
  Widget cancelButton = TextButton(
    child: const Text("Cancelar"),
    onPressed: funcionCancelar,
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(mensaje),
    actions: [
      okButton,
      cancelButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class _CartList extends StatelessWidget {

  
  @override
  Widget build(BuildContext context) {
    CartBloc cartBloc = BlocProvider.of<CartBloc>(context);
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.numberOfProductsInActiveCart,
          itemBuilder: (context, index) => ItemCarrito(
            cartBloc.findProductById(state.activeCartProductCarts[index].productId),
            state.activeCartProductCarts[index].quantity,
          ),
        );
      },
    );
  }
}
