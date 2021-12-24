class Transferencia {
  final double? valor;
  final int? numeroConta;

  Transferencia(
    this.numeroConta,
    this.valor,
  );

  @override
  String toString() {
    return 'Transferencia{numeroConta: $numeroConta, valor: $valor}';
  }
}
