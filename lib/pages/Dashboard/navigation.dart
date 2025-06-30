import 'package:admin_front/pages/Dashboard/dashboard.dart';
import 'package:admin_front/pages/Dashboard/home.dart';
import 'package:admin_front/pages/Dashboard/search.dart';
import 'package:admin_front/pages/Dashboard/setting.dart';
import 'package:admin_front/pages/provider/bottom_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Navigation extends StatelessWidget {
  const Navigation({super.key});

  final List<Widget> _pages = const [Home(), Dashboard(), Search(), Setting()];

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<BottomProvider>(context);
    return Scaffold(
      body: _pages[navProvider.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navProvider.currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        onTap: navProvider.changeIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
