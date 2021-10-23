import 'package:flutter/material.dart';
import 'package:tull_shopping_cart_app/pages/cart_page.dart';

import '../widgets/border_icon.dart';
import '../widgets/cart_icon_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      key: _scaffoldKey,
      endDrawer: const Drawer(child: CartPage()),
      body: Column(
        children: [
          comprasAppBar(),
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Center(
                  child: Text('Hola Mundo'),
                ),
              ],
            ),
          )
        ],
      ),
    ));
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
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Text(
              'Compras',
              style: Theme.of(context).textTheme.headline5,
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
}
