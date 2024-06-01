import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import '../screens/cart_page.dart';
import '../screens/home_screen.dart';
import '../screens/order_history.dart';
import '../screens/setting_page.dart';
import '../utils/color_const.dart';

class ButtomNavbar extends StatefulWidget {
  const ButtomNavbar({super.key});

  @override
  State<ButtomNavbar> createState() => _ButtomNavbarState();
}

class _ButtomNavbarState extends State<ButtomNavbar> {
  int _currentIndex = 0;
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  final _pages = [HomeScreen(), const OrderHistory(),const CartPage(), const SettingPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0), // Adjust the values as needed
          topRight: Radius.circular(20.0), // Adjust the values as needed
        ),
        child: IndexedStack(index: _currentIndex, children: _pages),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0), // Adjust the values as needed
          topRight: Radius.circular(20.0), // Adjust the values as needed
        ),
        child: BottomNavyBar(
          containerHeight: 60,
          selectedIndex: _currentIndex,
          showElevation: true,
          itemCornerRadius: 24,
          curve: Curves.elasticInOut,
          onItemSelected: (index) => setState(() => _currentIndex = index),
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
              icon: Icon(Icons.local_taxi_rounded),
              title: Text('Ride', style: Theme.of(context).textTheme.bodyLarge),
              activeColor: secondary,
              inactiveColor: primary,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.history),
              title: Text('History', style: Theme.of(context).textTheme.bodyLarge),
              activeColor: secondary,
              inactiveColor: primary,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Badge(
                label: Text('2'),
                child: Icon(Icons.messenger_sharp),
              ),
              title: Text('Cart', style: Theme.of(context).textTheme.bodyLarge),
              activeColor: secondary,
              inactiveColor: primary,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.settings),
              title: Text('Settings',style: Theme.of(context).textTheme.bodyLarge),
              activeColor: secondary,
              inactiveColor: primary,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
