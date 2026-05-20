import 'package:flutter/material.dart';
import '../models/tablero.dart';
import '../models/casilla.dart';

class GameScreen extends StatefulWidget {
  final int dificultad; // 0=Fácil, 1=Medio, 2=Difícil
  const GameScreen({super.key, this.dificultad = 0});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late Tablero tablero;

  @override
  void initState() {
    super.initState();
    _iniciarNuevaPartida();
  }

  void _iniciarNuevaPartida() {
    if (widget.dificultad == 0) {
      tablero = Tablero(filas: 6, columnas: 6, totalMinas: 10);
    } else if (widget.dificultad == 1) {
      tablero = Tablero(filas: 8, columnas: 8, totalMinas: 20);
    } else {
      tablero = Tablero(filas: 10, columnas: 10, totalMinas: 30);
    }
    setState(() {});
  }

  void _onTapCasilla(int fila, int col) {
    tablero.revelarCasilla(fila, col);
    setState(() {});
    if (tablero.juegoTerminado) _mostrarDialogoFinDelJuego();
  }

  void _onLongPressCasilla(int fila, int col) {
    tablero.alternarBandera(fila, col);
    setState(() {});
  }

  void _mostrarDialogoFinDelJuego() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(tablero.victoria ? '🎉 ¡GANASTE! 🎉' : '💣 ¡PERDISTE! 💣'),
        content: Text(tablero.victoria
            ? 'Revelaste todas las casillas seguras.\n¡Felicidades!'
            : 'Hiciste clic en una mina.\n¡Sigue intentando!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _iniciarNuevaPartida();
            },
            child: const Text('REINTENTAR'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('SALIR'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Busca Minas'),
        centerTitle: true,
        backgroundColor: Colors.green[800],
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _iniciarNuevaPartida,
            tooltip: 'Nueva partida',
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.bug_report, color: Colors.red),
                    const SizedBox(width: 8),
                    Text('Minas restantes: ${tablero.getMinasRestantes()}',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(child: _buildGrid()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGrid() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: tablero.columnas,
        childAspectRatio: 1.0,
      ),
      itemCount: tablero.filas * tablero.columnas,
      itemBuilder: (context, index) {
        int fila = index ~/ tablero.columnas;
        int col = index % tablero.columnas;
        Casilla casilla = tablero.grid[fila][col];
        return GestureDetector(
          onTap: () => _onTapCasilla(fila, col),
          onLongPress: () => _onLongPressCasilla(fila, col),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade700, width: 1),
              color: _getColorFondo(casilla),
            ),
            child: Center(child: _getContenidoCasilla(casilla)),
          ),
        );
      },
    );
  }

  Color _getColorFondo(Casilla casilla) {
    if (casilla.estaRevelada) return Colors.grey.shade300;
    if (casilla.tieneBandera) return Colors.grey.shade700;
    return Colors.grey.shade600;
  }

  Widget _getContenidoCasilla(Casilla casilla) {
    if (!casilla.estaRevelada) {
      if (casilla.tieneBandera) return const Icon(Icons.flag, color: Colors.red, size: 20);
      return Container();
    }
    if (casilla.esMina) return const Icon(Icons.bug_report, color: Colors.black, size: 20);
    if (casilla.minasAlrededor > 0) {
      return Text(
        '${casilla.minasAlrededor}',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: _getColorNumero(casilla.minasAlrededor)),
      );
    }
    return Container();
  }

  Color _getColorNumero(int numero) {
    switch (numero) {
      case 1: return Colors.blue;
      case 2: return Colors.green;
      case 3: return Colors.red;
      case 4: return Colors.purple;
      case 5: return Colors.orange;
      case 6: return Colors.teal;
      default: return Colors.black;
    }
  }
}