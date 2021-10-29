import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/cart_bloc/cart_bloc.dart';
import '../models/cart_model.dart';
import '../models/product_cart_model.dart';
import '../models/producto_model.dart';
import '../pages/cart_page.dart';
import '../widgets/border_icon.dart';
import '../widgets/cart_icon_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Product> currentProducts = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cargarDatosLocales();
  }

  Future<void> _cargarDatosLocales() async {
    CartBloc cartBloc = BlocProvider.of<CartBloc>(context);

    // List<Cart> carts = await cargarCarts();
    // List<Product> products = await cargarProductos();
    // List<ProductCart> productCarts = await cargarProductCarts();
    cargarProductos().then((prods) {
      if (prods != null) {
        cartBloc.productsManager(prods);
      }
      cargarCarts().then((carts) {
        if (carts != null) {
          cartBloc.cartsManager(carts);
        }
        cargarProductCarts().then((productCarts) {
          print(productCarts);
          if (productCarts != null) {
            cartBloc.productCartsManager(productCarts);
          }
          cartBloc.computeTotal();
        });
      });
    });
    return;
  }

  Future<List<Product>> cargarProductos() async {
    final jsonResponse =
        await rootBundle.loadString('assets/local_data/products.json');
    return productsFromJson(jsonResponse);
  }

  Future<List<Cart>> cargarCarts() async {
    final jsonResponse =
        await rootBundle.loadString('assets/local_data/carts.json');
    return cartsFromJson(jsonResponse);
  }

  Future<List<ProductCart>> cargarProductCarts() async {
    final jsonResponse =
        await rootBundle.loadString('assets/local_data/product_carts.json');
    return productCartsFromJson(jsonResponse);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        endDrawer: const Drawer(child: CartPage()),
        body: Column(
          children: [
            comprasAppBar(),
            const Divider(thickness: 0, height: 16),
            Expanded(child: SingleChildScrollView(
              child: BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  // Esta version no permite poner el "for" dentro de los children de la columna :(
                  List<Widget> wids = <Widget>[];
                  if (searchController?.text?.isNotEmpty ?? true) {
                    for (Product product in currentProducts) {
                      wids.add(ProductWidget(product,
                          key: Key(
                              product.id.toString()))); // TODO: Product Widget
                    }
                  } else {
                    wids =
                        state.products.map((pr) => ProductWidget(pr)).toList();
                  }
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: wids,
                  );
                },
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget comprasAppBar() {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => _scaffoldKey.currentState.openDrawer(),
            child: const BorderIcon(
              child: Icon(Icons.menu),
              height: 50,
              width: 50,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 0),
              child: _searchBox(),
            ),
          ),
          InkWell(
            onTap: () => _scaffoldKey.currentState.openEndDrawer(),
            child: const CartIconButton(),
          ),
        ],
      ),
    );
  }

  Widget _searchBox() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 10.0),
      child: TextField(
        autofocus: false,
        controller: searchController,
        textCapitalization: TextCapitalization.words,
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            gapPadding: 4.0,
            borderRadius: BorderRadius.all(Radius.circular(2)),
          ),
          hintText: 'Buscar Productos',
          suffixIcon: Icon(Icons.search),
        ),
        onChanged: _buscar,
      ),
    );
  }

  _buscar(String text) async {
    CartBloc cartBloc = BlocProvider.of<CartBloc>(context);
    currentProducts = [];
    try {
      // Check if null and empty
      if (text?.isNotEmpty ?? true) {
        for (var product in cartBloc.state.products) {
          if (product.name.toLowerCase().contains(text.toLowerCase())) {
            currentProducts.add(product);
          }
        }
      } else {
        currentProducts = cartBloc.state.products;
      }
    } catch (e) {
      print('error en la busqueda'); // for debugging
      currentProducts = cartBloc.state.products;
    }
    setState(() {});
  }
}

class ProductWidget extends StatelessWidget {
  const ProductWidget(
    this.product, {
    Key key,
  }) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    CartBloc cartBloc = BlocProvider.of<CartBloc>(context);
    return ListTile(
      title: Text(product.name),
      subtitle: Text(product.description),
      leading: Text("\$ ${product.price.toStringAsFixed(2)}"),
      trailing: IconButton(
          onPressed: () {
            cartBloc.addItemToCart(product.id);
          },
          icon: const Icon(Icons.shopping_cart)),
    );
  }
}
