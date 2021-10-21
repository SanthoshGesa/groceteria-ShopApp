import 'package:flutter/material.dart';
import 'package:store/screens/dashboard.dart';
import 'package:store/screens/orders.dart';
import 'package:store/screens/products.dart';
import 'package:store/screens/settings.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _currentIndex = 0;
  List _pages = [
    DashBoardScreen(),
    ProductsScreen(),
    OrdersScreen(),
    SettingsScreen(),
  ];

  changeIndex(index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: changeIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.green,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_on_outlined),
            label: "Products",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: "Orders",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: "Settings",
          )
        ],
      ),
    );
  }
}
