import 'package:bytebank/constant/constants.dart';
import 'package:bytebank/screens/transferencia/lista.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(nomeApp),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.asset('assets/images/bytebank_logo.png'),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Material(
              color: Theme.of(context).primaryColor,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ListaTransferencias(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  height: 120,
                  width: 160,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Icon(
                        Icons.list_alt,
                        color: Colors.white,
                        size: 32,
                      ),
                      Text(
                        "Lista de Transferências",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
