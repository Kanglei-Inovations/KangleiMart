import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage =  FirebaseStorage.instance;
  final SharedPreferences prefs;
  MyApp({super.key, required this.prefs});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => AuthProviders()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => OrdersProvider()),
        ChangeNotifierProvider(create: (_) => ProductsProvider()),
      ],
      child: Consumer<AuthProviders>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'KangleiMart',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            hintColor: Colors.green,
            fontFamily: 'Lato',
          ),
          home: AuthChecker(),
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
class AuthChecker extends StatefulWidget {

  @override
  State<AuthChecker> createState() => _AuthCheckerState();
}

class _AuthCheckerState extends State<AuthChecker> {
  bool? isLoggedIn;

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    bool loggedIn = await Provider.of<AuthProviders>(context, listen: false).checkAuthStatus();
    setState(() {
      isLoggedIn = loggedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn == null) {
      // Still checking auth status
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (isLoggedIn!) {
      // User is logged in
      return HomeScreen();
    } else {
      // User is not logged in
      return LoginScreen();
    }
  }
}