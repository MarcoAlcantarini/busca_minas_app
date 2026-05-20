import 'package:flutter/material.dart';
import 'game_screen.dart'; 
import 'instructions_screen.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.videogame_asset, size: 70, color: Color(0xFFE94560)),
                const SizedBox(height: 10),
                const Text('MENÚ PRINCIPAL', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 2)),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Divider(color: Color(0xFF16213E), thickness: 2, height: 40),
                ),
                _buildMenuButton(context, 'FÁCIL (6x6)', const Color(0xFF4E9F3D), 0, Icons.sentiment_satisfied_alt),
                _buildMenuButton(context, 'MEDIO (8x8)', const Color(0xFFD4A017), 1, Icons.sentiment_neutral),
                _buildMenuButton(context, 'DIFÍCIL (10x10)', const Color(0xFFE94560), 2, Icons.sentiment_very_dissatisfied),
                const SizedBox(height: 20),
                _buildMenuButton(context, 'INSTRUCCIONES', const Color(0xFF0F3460), -1, Icons.help_outline),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, String text, Color color, int dificultad, IconData icon) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: 250,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 5,
        ),
        onPressed: () {
          if (dificultad == -1) {
            // Instrucciones
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const InstructionsScreen()),
            );
          } else {
            // Juego con la dificultad seleccionada
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GameScreen(dificultad: dificultad)),
            );
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24),
            const SizedBox(width: 12),
            Text(text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
          ],
        ),
      ),
    );
  }
}