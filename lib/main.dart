// lib/main.dart
import 'package:flutter/material.dart';
import 'screens/game_screen.dart';

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
        scaffoldBackgroundColor: Colors.grey[900],
      ),
      home: const GameScreen(),
    );
  }
}