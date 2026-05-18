import 'package:flutter/material.dart';

class InstructionsScreen extends StatelessWidget {
  const InstructionsScreen({super.key});

  // Widget auxiliar para crear las tarjetas de reglas
  Widget _buildInstructionCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String description,
  }) {
    return Card(
      color: const Color(0xFF16213E),
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: iconColor, size: 30),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ],
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
      app: AppBar(
        backgroundColor: const Color(0xFF1A1A2E),
        elevation: 0,
        title: const Text(
          '¿Cómo jugar?',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildInstructionCard(
              icon: Icons.grid_on,
              iconColor: Colors.blue,
              title: 'El Tablero',
              description:
                  'El juego consiste en despejar un cuadrante de casillas sin detonar ninguna mina oculta.',
            ),
            _buildInstructionCard(
              icon: Icons.ads_click,
              iconColor: Colors.green,
              title: 'Revelar Casillas',
              description:
                  'Toca una casilla para ver qué hay dentro. Si muestra un número, este indica cuántas minas hay en los 8 casilleros que la rodean.',
            ),
            _buildInstructionCard(
              icon: Icons.flag,
              iconColor: Colors.amber,
              title: 'Colocar Banderas',
              description:
                  'Mantén presionada una casilla donde sospeches con certeza que hay una mina para marcarla con una bandera y protegerla.',
            ),
            _buildInstructionCard(
              icon: Icons.gpp_maybe,
              iconColor: Colors.red,
              title: 'Condición de Victoria',
              description:
                  'Ganas el juego cuando logras descubrir todas las casillas vacías o con números seguros. Pierdes inmediatamente si tocas una mina.',
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE94560),
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text(
                '¡ENTENDIDO!',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
