import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:bytebank/screens/transferencia/formulario.dart';
import 'package:bytebank/constant/constants.dart';
import 'package:flutter/material.dart';

/*body: ListView.builder(
          itemCount: widget._transferencias.length,
          itemBuilder: (context, indice) {
            final transferencia = widget._transferencias[indice];
            return ItemTransferencia(transferencia);
          },
        )
*/

class ListaTransferencias extends StatefulWidget {
  const ListaTransferencias({Key? key}) : super(key: key);

  @override
  State<ListaTransferencias> createState() => _ListaTransferenciasState();
}

class _ListaTransferenciasState extends State<ListaTransferencias> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(tituloAppBarFormularioTransferencias),
      ),
      body: FutureBuilder<List<Transferencia>>(
        initialData: const [],
        future: findAll(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                    Text('Carregando...'),
                  ],
                ),
              );
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final List<Transferencia> transferencias = snapshot.data;
              return ListView.builder(
                itemBuilder: (context, indice) {
                  final transferencia = transferencias[indice];
                  return ItemTransferencia(transferencia);
                },
                itemCount: transferencias.length,
              );
          }
          return const Text('Unknown error');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (context) => const FormularioTransferencia(),
            ),
          )
              .then(
            (value) {
              setState(() {});
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;
  const ItemTransferencia(this._transferencia, {Key? key}) : super(key: key);

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
