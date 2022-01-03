import 'package:bytebank/components/editor.dart';
import 'package:bytebank/constant/constants.dart';
import 'package:bytebank/database/dao/transferencia_dao.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:flutter/material.dart';

class FormularioTransferencia extends StatefulWidget {
  const FormularioTransferencia({Key? key}) : super(key: key);

  @override
  State<FormularioTransferencia> createState() =>
      _FormularioTransferenciaState();
}

class _FormularioTransferenciaState extends State<FormularioTransferencia> {
  final TextEditingController _controladorCampoNumeroConta =
      TextEditingController();

  final TextEditingController _controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(tituloAppBarFormularioTransferencias),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Editor(
                controlador: _controladorCampoNumeroConta,
                rotulo: rotuloNumeroConta,
                dica: dicaNumeroConta),
            Editor(
                controlador: _controladorCampoValor,
                rotulo: rotuloValorTransferencia,
                dica: dicaValorTransferencia,
                icone: Icons.monetization_on),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  child: const Text(textoBotaoConfirmar),
                  onPressed: () => _criaTransferencia(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //CORRIGIR ID = 0;

  void _criaTransferencia(BuildContext context) {
    const int id = 0;
    final int? numeroConta = int.tryParse(_controladorCampoNumeroConta.text);
    final double? valorTransferencia =
        double.tryParse(_controladorCampoValor.text);
    final TransferenciaDao _transferenciaDao = TransferenciaDao();

    if (numeroConta != null && valorTransferencia != null) {
      final Transferencia transferenciaCriada = Transferencia(
        id,
        numeroConta,
        valorTransferencia,
      );
      _transferenciaDao.save(transferenciaCriada).then(
            (id) => Navigator.pop(context),
          );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: const <Widget>[
              Icon(Icons.price_check),
              Text(mensagemSucessoTransferencia),
            ],
          ),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }
}
