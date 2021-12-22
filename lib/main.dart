import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        home: Scaffold(
          body: ListaTranferencias(),
          appBar: AppBar(
            title: const Text('Transferências'),
            backgroundColor: Colors.blueGrey[900],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.add),
            backgroundColor: Colors.blueGrey[900],
          ),
        ),
      ),
    );

class ListaTranferencias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      ItemTransferencia(Transferencia(100.0, 572)),
      ItemTransferencia(Transferencia(100.0, 572)),
      ItemTransferencia(Transferencia(100.0, 572)),
      ItemTransferencia(Transferencia(147.0, 572)),
    ]);
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;
  ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.monetization_on),
        title: Text(_transferencia.valor.toString()),
        subtitle: Text(_transferencia.numeroConta.toString()),
      ),
    );
  }
}

class Transferencia {
  final double valor;
  final int numeroConta;

  Transferencia(this.valor, this.numeroConta);
}
