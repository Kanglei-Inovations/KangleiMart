import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kangleimart/providers/auth_provider.dart';
import 'package:kangleimart/screens/login_screen.dart';
import 'package:kangleimart/utils/text_const.dart';
import 'package:provider/provider.dart';
import '../screens/home_screen.dart';
import '../screens/cart_page.dart';
import '../screens/orders_screen.dart';
import '../screens/profile_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Hello, User!'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: MyAppText(text: 'Shopping', fontSize: 14.sp,),
            onTap: () {
              //Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: MyAppText(text: 'Orders', fontSize: 14.sp,),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: MyAppText(text: 'Cart', fontSize: 14.sp,),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(CartPage.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: MyAppText(text: 'Profile', fontSize: 14.sp,),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(ProfileScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: MyAppText(text: 'Settings', fontSize: 14.sp,),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(ProfileScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: MyAppText(text: 'Logout', fontSize: 14.sp,),
            onTap: () {
              Provider.of<AuthProviders>(context, listen: false).logout;
              Navigator.of(context).pushNamed('/LoginScreen');
                          },
          ),
        ],
      ),
    );
  }
}
