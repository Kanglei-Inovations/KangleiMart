import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kangleimart/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kangleimart/providers/auth_provider.dart';
import 'package:kangleimart/providers/cart_provider.dart';
import 'package:kangleimart/providers/orders_provider.dart';
import 'package:kangleimart/providers/products_provider.dart';
import 'package:kangleimart/screens/cart_page.dart';
import 'package:kangleimart/screens/orders_screen.dart';
import 'package:kangleimart/screens/profile_screen.dart';
import 'package:kangleimart/screens/product_screen.dart';
import 'package:kangleimart/screens/login_screen.dart';
import 'package:kangleimart/screens/signup_screen.dart';
import 'package:kangleimart/screens/home_screen.dart';

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
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => OrdersProvider()),
        ChangeNotifierProvider(create: (_) => ProductsProvider()),
      ],
      child: Consumer<AuthProvider>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'KangleiMart',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            hintColor: Colors.green,
            fontFamily: 'Lato',
          ),
          home: auth.isLoggedIn ? HomeScreen() : LoginScreen(),
          routes: {
            '/SignUpScreen': (ctx) => SignUpScreen(),
            '/LoginScreen': (ctx) => LoginScreen(),
            '/HomeScreen': (ctx) => HomeScreen(),
            '/ProductScreen': (ctx) => ProductScreen(),
            '/CartPage': (ctx) => CartPage(),
            '/OrdersScreen': (ctx) => OrdersScreen(),
            '/ProfileScreen': (ctx) => ProfileScreen(),



          },
        ),
      ),
    );
  }
}
