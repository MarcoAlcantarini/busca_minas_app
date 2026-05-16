import 'dart:math';
import 'casilla.dart';

class Tablero {
  int filas;
  int columnas;
  int totalMinas;
  List<List<Casilla>> grid;
  bool juegoTerminado = false;
  bool victoria = false;
  int casillasReveladas = 0;

  Tablero({
    required this.filas,
    required this.columnas,
    required this.totalMinas,
  }) : grid = List.generate(filas, (_) => List.generate(columnas, (_) => Casilla(esMina: false))) {
    _inicializarJuego();
  }

  void _inicializarJuego() {
    juegoTerminado = false;
    victoria = false;
    casillasReveladas = 0;
    _colocarMinas();
    _calcularNumeros();
  }

  void _colocarMinas() {
    Random rand = Random();
    int minasColocadas = 0;
    while (minasColocadas < totalMinas) {
      int fila = rand.nextInt(filas);
      int col = rand.nextInt(columnas);
      if (!grid[fila][col].esMina) {
        grid[fila][col] = Casilla(esMina: true);
        minasColocadas++;
      }
    }
  }

  void _calcularNumeros() {
    for (int i = 0; i < filas; i++) {
      for (int j = 0; j < columnas; j++) {
        if (grid[i][j].esMina) continue;
        int count = 0;
        // Revisar las 8 casillas vecinas
        for (int di = -1; di <= 1; di++) {
          for (int dj = -1; dj <= 1; dj++) {
            int ni = i + di;
            int nj = j + dj;
            if (ni >= 0 && ni < filas && nj >= 0 && nj < columnas && grid[ni][nj].esMina) {
              count++;
            }
          }
        }
        grid[i][j].minasAlrededor = count;
      }
    }
  }

  void revelarCasilla(int fila, int col) {
    if (juegoTerminado) return;
    
    Casilla casilla = grid[fila][col];
    
    // No revelar si ya está revelada o tiene bandera
    if (casilla.estaRevelada || casilla.tieneBandera) return;

    if (casilla.esMina) {
      // PERDISTE
      juegoTerminado = true;
      victoria = false;
      return;
    }

    // Revelar la casilla
    casilla.estaRevelada = true;
    casillasReveladas++;

    // Si es una casilla vacía (0 minas alrededor), revelar los vecinos
    if (casilla.minasAlrededor == 0) {
      for (int di = -1; di <= 1; di++) {
        for (int dj = -1; dj <= 1; dj++) {
          int ni = fila + di;
          int nj = col + dj;
          if (ni >= 0 && ni < filas && nj >= 0 && nj < columnas) {
            if (!grid[ni][nj].estaRevelada && !grid[ni][nj].esMina) {
              revelarCasilla(ni, nj);
            }
          }
        }
      }
    }
    
    _verificarVictoria();
  }

  void _verificarVictoria() {
    // Victoria: todas las casillas que NO son minas están reveladas
    int casillasSeguras = (filas * columnas) - totalMinas;
    if (casillasReveladas == casillasSeguras) {
      juegoTerminado = true;
      victoria = true;
    }
  }

  void alternarBandera(int fila, int col) {
    if (juegoTerminado) return;
    Casilla casilla = grid[fila][col];
    if (!casilla.estaRevelada) {
      casilla.tieneBandera = !casilla.tieneBandera;
    }
  }

  void reiniciar() {
    grid = List.generate(filas, (_) => List.generate(columnas, (_) => Casilla(esMina: false)));
    _inicializarJuego();
  }

  int getMinasRestantes() {
    int banderas = 0;
    for (var fila in grid) {
      for (var casilla in fila) {
        if (casilla.tieneBandera) banderas++;
      }
    }
    return totalMinas - banderas;
  }
}