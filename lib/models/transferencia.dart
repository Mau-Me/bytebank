class Transferencia {
  final int? id;
  final int? numeroConta;
  final double? valor;

  Transferencia(
    this.id,
    this.numeroConta,
    this.valor,
  );

  @override
  String toString() {
    return 'Transferencia{id: $id, numeroConta: $numeroConta, valor: $valor}';
  }
}
