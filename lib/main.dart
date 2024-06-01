import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kangleimart/firebase_options.dart';
import 'package:kangleimart/screens/home_screen.dart';
import 'package:kangleimart/screens/profile_screen.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'providers/auth_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/orders_provider.dart';
import 'providers/products_provider.dart';
import 'screens/cart_page.dart';
import 'screens/orders_screen.dart';
import 'screens/product_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.deepPurpleAccent, // Change this to your desired color
  ));
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProviders()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => OrdersProvider()),
        ChangeNotifierProvider(create: (_) => ProductsProvider()),
      ],
      child: MaterialApp(
        title: 'KangleiMart',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          hintColor: Colors.green,
          fontFamily: 'Lato',
        ),
        initialRoute: '/', // Set initial route here
        routes: {
          '/': (ctx) => HomeScreen(), // Define your routes
          '/CartPage': (ctx) => CartPage(),
          '/OrdersScreen': (ctx) =>OrdersScreen(),
          '/ProfileScreen': (ctx) => ProfileScreen(),
          '/ProductScreen': (ctx) => ProductScreen(),
          // Add more routes as needed
        },
      ),
    );
  }
}