class Casilla {
  final bool esMina;
  int minasAlrededor;
  bool estaRevelada;
  bool tieneBandera;

  Casilla({
    required this.esMina,
    this.minasAlrededor = 0,
    this.estaRevelada = false,
    this.tieneBandera = false,
  });

  // Para ver el estado en la consola (ayuda a depurar)
  @override
  String toString() {
    if (esMina) return '*';
    if (minasAlrededor == 0) return ' ';
    return '$minasAlrededor';
  }
}