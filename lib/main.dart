import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin_front/pages/Dashboard/navigation.dart';
import 'package:admin_front/pages/login_page/login_page.dart';
import 'package:admin_front/pages/provider/bottom_provider.dart';
import 'package:admin_front/pages/login_page/register_page.dart';
import 'package:admin_front/pages/Dashboard/dashboard_page/add_product.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => BottomProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/navigation': (context) => const Navigation(),
        '/addproduct': (context) => const AddProduct(),
      },
    );
  }
}
