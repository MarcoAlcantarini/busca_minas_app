import 'package:flutter/material.dart';
import 'screens/main_menu_screen.dart';

void main() {
  runApp(const BuscaMinasApp());
}

class BuscaMinasApp extends StatelessWidget {
  const BuscaMinasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Busca Minas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.green,
        scaffoldBackgroundColor: const Color(0xFF1A1A2E),
      ),
      home: const MainMenuScreen(),
    );
  }
}