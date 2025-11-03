import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const PSPMedPrepApp());
}

class PSPMedPrepApp extends StatelessWidget {
  const PSPMedPrepApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PSP MedPrep',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}