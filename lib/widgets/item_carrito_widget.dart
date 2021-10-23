import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tull_shopping_cart_app/blocs/bloc/cart_bloc.dart';
import 'package:tull_shopping_cart_app/models/cart_model.dart';
import 'package:tull_shopping_cart_app/models/producto_model.dart';

// ignore: must_be_immutable
class ItemCarrito extends StatefulWidget {
  // final CartItemState _cartItemState;
  final Product producto;
  int _cantidad;
  // final TextEditingController _newcantidadController = TextEditingController();

  ItemCarrito(this.producto, this._cantidad, {Key key}) : super(key: key);

  @override
  _ItemCarritoState createState() => _ItemCarritoState();
}

class _ItemCarritoState extends State<ItemCarrito> {
  @override
  Widget build(BuildContext context) {
    final existencia = widget.producto.sku;
    // print(' Cantidad : ${widget.producto.productoExistencia}');
    final carrito = Provider.of<Cart>(context, listen: false);

    CartBloc cartBloc = BlocProvider.of<CartBloc>(context);

    final imageWidget =
        Image.asset('assets/img/noImageFound.png', fit: BoxFit.cover);
    final descriptionWidget = Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.producto.description,
            style: Theme.of(context).textTheme.subtitle1,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          'Cantidad',
          style: Theme.of(context).textTheme.bodyText1,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  if (widget._cantidad > 1) {
                    cartBloc.editQuantity(widget.producto.id, widget._cantidad - 1);
                    setState(() {
                      widget._cantidad--;
                    });
                  }
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                widget._cantidad.toString(),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  if (existencia > widget._cantidad) {
                    cartBloc.editQuantity(widget.producto.id, widget._cantidad + 1);
                    setState(() {
                      widget._cantidad++;
                    });
                  }
                },
              ),
            )
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              '\$' + widget.producto.price.toString() + ' c/u',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
        )
      ],
    );

    return Container(
      height: 150,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        shadowColor: Theme.of(context).primaryColor,
        elevation: 3.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: SizedBox(
                height: 150,
                child: imageWidget,
              ),
            ),
            Expanded(flex: 2, child: descriptionWidget),
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                cartBloc.removeCartItemFromCart(widget.producto.id);
              },
              // onPressed: () => cartBloc.removeCartItemOfCart(_cartItemState),
            )
          ],
        ),
      ),
    );
  }
}
