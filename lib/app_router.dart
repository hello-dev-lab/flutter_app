import 'package:flutter/material.dart';
import 'package:admin_front/pages/Dashboard/navigation.dart';
import 'package:admin_front/pages/login_page/login_page.dart';
import 'package:admin_front/pages/login_page/register_page.dart';
import 'package:admin_front/pages/splashScreen/splash_screen.dart';
import 'package:admin_front/pages/Dashboard/dashboard_page/add_product.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case '/register':
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case '/navigation':
        return MaterialPageRoute(builder: (_) => const Navigation());
      case '/addproduct':
        return MaterialPageRoute(builder: (_) => const AddProduct());
      default:
        return  MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Page not found')),
          ),
        );
    }
  }
}
