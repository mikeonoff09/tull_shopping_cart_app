import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tull_shopping_cart_app/blocs/bloc/cart_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (BuildContext context) {},
      child: MultiBlocProvider(
        providers: [BlocProvider(create: (_) => CartBloc())],
        child: MaterialApp(
          title: 'Material App',
          home: Scaffold(
            appBar: AppBar(
              title: const Text('Material App Bar'),
            ),
            body: const Center(
              child: Text('Hello World'),
            ),
          ),
        ),
      ),
    );
  }
}
