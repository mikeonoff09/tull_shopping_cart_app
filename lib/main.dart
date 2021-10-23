import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'blocs/bloc/cart_bloc.dart';
import 'pages/home_page.dart';

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
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Material App',
          home: HomePage(),
        ),
      ),
    );
  }
}
