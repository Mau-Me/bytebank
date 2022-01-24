import 'package:bytebank/database/dao/transferencia_dao.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:bytebank/screens/transferencia/formulario.dart';
import 'package:bytebank/constant/constants.dart';
import 'package:flutter/material.dart';

class ListaTransferencias extends StatefulWidget {
  const ListaTransferencias({Key? key}) : super(key: key);

  @override
  State<ListaTransferencias> createState() => _ListaTransferenciasState();
}

class _ListaTransferenciasState extends State<ListaTransferencias> {
  final TransferenciaDao _transferenciaDao = TransferenciaDao();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(tituloAppBarListaTransferencias),
      ),
      body: FutureBuilder<List<Transferencia>>(
        initialData: const [],
        future: _transferenciaDao.findAll(),
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
                    Text(mensagemCarregamento),
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
      trailing: SizedBox(
        width: 100,
        child: Row(children: [
          IconButton(
            icon: const Icon(Icons.edit),
            color: Colors.orange[300],
            onPressed: () {
              _editarTransferencia(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            color: Colors.red[300],
            onPressed: () {
              _deletaTransferencia(context);
            },
          ),
        ]),
      ),
    ));
  }

  void _deletaTransferencia(BuildContext context) {
    final TransferenciaDao _transferenciaDao = TransferenciaDao();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Número da Conta: ${_transferencia.numeroConta}'),
          content: Text(
              'Tem certeza que deseja excluir a transferencia ${_transferencia.valor}?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Apagar'),
              onPressed: () {
                Navigator.of(context).pop();
                _transferenciaDao.delete(_transferencia.id!);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: const <Widget>[
                        Icon(Icons.price_check),
                        Text("mensagemTransferenciaDeletada"),
                      ],
                    ),
                    duration: const Duration(seconds: 3),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _editarTransferencia(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const FormularioTransferencia(),
      ),
    );
  }
}
