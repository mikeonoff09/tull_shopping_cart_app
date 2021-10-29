import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tull_shopping_cart_app/blocs/cart_bloc/cart_bloc.dart';
import 'package:tull_shopping_cart_app/models/producto_model.dart';

class ItemCard extends StatefulWidget {
  final Product producto;
  // final Cart carrito;
  const ItemCard({
    // @required this.carrito,
    @required this.producto,
    Key key,
  }) : super(key: key);

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  int cantidad = 1;
  @override
  Widget build(BuildContext context) {
    CartBloc cartBloc = BlocProvider.of<CartBloc>(context);
    return Card(
      child: Container(
        // color: Theme.of(context).backgroundColor,
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              flex: 5,
              child: InkWell(
                child: Image.asset('assets/img/noImageFound.png',
                    fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.producto.description,
                  maxLines: 2, overflow: TextOverflow.ellipsis),
            ),
            _selector(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('\$' + widget.producto.price.toString(),
                    style: Theme.of(context).textTheme.headline6),
                Text(' c/u', style: Theme.of(context).textTheme.bodyText1),
                IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () => cartBloc.addItemToCart(widget.producto.id),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _selector(BuildContext context) {
    return SizedBox(
      // padding: EdgeInsets.all(8.0),
      width: MediaQuery.of(context).size.width * 0.9,
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              decoration: decoration(context),
              child: IconButton(
                icon: const Icon(Icons.exposure_minus_1, color: Colors.black45),
                onPressed: () {
                  setState(() {
                    // ignore: unnecessary_statements
                    cantidad > 1 ? cantidad-- : null;
                  });
                },
              ),
            ),
          ),
          Expanded(
            child: Text(cantidad.toString(),
                style: const TextStyle(fontSize: 26),
                textAlign: TextAlign.center),
          ),
          Expanded(
            child: Container(
              decoration: decoration(context),
              child: IconButton(
                // color: Colors.amber,
                icon: const Icon(Icons.plus_one, color: Colors.black45),
                onPressed: () {
                  setState(() {
                    widget.producto.sku >= cantidad
                        ? cantidad++
                        // ignore: unnecessary_statements
                        : null;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration decoration(BuildContext context) {
    return BoxDecoration(
      // color: Colors.white,
      color: Theme.of(context).backgroundColor,
      borderRadius: BorderRadius.circular(0),
      border: Border.all(
        color: Theme.of(context).primaryColor,
        width: 1,
      ),
     );
  }
}
