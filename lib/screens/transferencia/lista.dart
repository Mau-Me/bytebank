import 'package:bytebank/models/transferencia.dart';
import 'package:flutter/material.dart';

import 'formulario.dart';

const _tituloAppBar = 'Lista de Transferências';
const _mensagemSucesso = 'Transferência realizada com sucesso!';

class ListaTransferencias extends StatefulWidget {
  final _transferencias = <Transferencia>[];

  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciasState();
  }
}

class ListaTransferenciasState extends State<ListaTransferencias> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(_tituloAppBar),
        ),
        body: ListView.builder(
          itemCount: widget._transferencias.length,
          itemBuilder: (context, indice) {
            final transferencia = widget._transferencias[indice];
            return ItemTransferencia(transferencia);
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final Future<Transferencia?> future = Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FormularioTransferencia(),
              ),
            );
            atualiza(future, context);
          },
          child: const Icon(Icons.add),
        ));
  }

  void atualiza(Future<Transferencia?> future, BuildContext context) {
    future.then((transfereniaRecebida) {
      if (transfereniaRecebida != null) {
        setState(
          () {
            widget._transferencias.add(transfereniaRecebida);
          },
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(_mensagemSucesso),
          ),
        );
      }
    });
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
