import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
void initState() {
  super.initState();
  Timer(const Duration(seconds: 3), () {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacementNamed(context, '/login');
    });
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.abc, size: 100),
            SizedBox(height: 20),
            Text('Splash Screen', style: TextStyle(fontSize: 30)),
            const CircularProgressIndicator(
            color: Colors.white, // optional: change color
            strokeWidth: 4.0,
          ),
          ],
        ),
      ),
    );
  }
}
