import 'package:flutter/material.dart';
import 'instructions_screen.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  // Función auxiliar para construir los botones del menú
  Widget _buildMenuButton({
    required String text,
    required Color color,
    required VoidCallback onPressed,
    IconData? icon,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: 250,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 24),
              const SizedBox(width: 12),
            ],
            Text(
              text,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

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
                // Encabezado del Menú
                const Icon(
                  Icons.videogame_asset,
                  size: 70,
                  color: Color(0xFFE94560),
                ),
                const SizedBox(height: 10),
                const Text(
                  'MENÚ PRINCIPAL',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Divider(
                    color: Color(0xFF16213E),
                    thickness: 2,
                    height: 40,
                  ),
                ),

                // Botones de Dificultad / Jugar
                _buildMenuButton(
                  text: 'FÁCIL (9x9)',
                  color: const Color(0xFF4E9F3D),
                  icon: Icons.sentiment_satisfied_alt,
                  onPressed: () {
                    // Aquí conectarás con tu pantalla de juego pasando filas: 9, columnas: 9, minas: 10
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Iniciando modo Fácil...')),
                    );
                  },
                ),
                _buildMenuButton(
                  text: 'MEDIO (16x16)',
                  color: const Color(0), // Amarillo/Naranja oscuro
                  icon: Icons.sentiment_neutral,
                  onPressed: () {
                    // Pasar filas: 16, columnas: 16, minas: 40
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Iniciando modo Medio...')),
                    );
                  },
                ),
                _buildMenuButton(
                  text: 'DIFÍCIL (16x30)',
                  color: const Color(0xFFE94560),
                  icon: Icons.sentiment_very_dissatisfied,
                  onPressed: () {
                    // Pasar filas: 16, columnas: 30, minas: 99
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Iniciando modo Difícil...'),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20),

                // Botón de Instrucciones
                _buildMenuButton(
                  text: 'INSTRUCCIONES',
                  color: const Color(0xFF0F3460),
                  icon: Icons.help_outline,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const InstructionsScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
