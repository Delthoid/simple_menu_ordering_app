import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:menu_ordering_app/presentation/screens/cart.dart';
import 'package:menu_ordering_app/presentation/screens/homepage.dart';
import 'package:menu_ordering_app/presentation/screens/item_info/item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FoodZ',
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      routes: {
        //Homepage route
        '/': (context) => const HomePage(title: 'Cornelia St.'),
        '/cart': (context) => const Cart(),
      },
      theme: ThemeData(
        primarySwatch: Colors.pink,
        textTheme: const TextTheme(
          headline1: TextStyle(
              fontSize: 72.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat'),
          headline6: TextStyle(
            fontSize: 20.0,
            color: Colors.black,
            fontFamily: 'Montserrat',
          ),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Montserrat'),
        ),
      ),
    );
  }
}
