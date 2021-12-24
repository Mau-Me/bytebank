import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:flutter/material.dart';

const _tituloAppBar = 'Criando Transferência';
const _rotuloNumeroConta = 'Número da Conta';
const _rotuloValorTransferencia = 'Valor da Transferência';
const _dicaNumeroConta = '0000';
const _dicaValorTransferencia = '0.00';
const _textoBotaoConfirmar = 'Confirmar';

class FormularioTransferencia extends StatefulWidget {
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
        title: const Text(_tituloAppBar),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Editor(
                controlador: _controladorCampoNumeroConta,
                rotulo: _rotuloNumeroConta,
                dica: _dicaNumeroConta),
            Editor(
                controlador: _controladorCampoValor,
                rotulo: _rotuloValorTransferencia,
                dica: _dicaValorTransferencia,
                icone: Icons.monetization_on),
            ElevatedButton(
              child: const Text(_textoBotaoConfirmar),
              onPressed: () => _criaTransferencia(context),
            ),
          ],
        ),
      ),
    );
  }

  void _criaTransferencia(BuildContext context) {
    final int? numeroConta = int.tryParse(_controladorCampoNumeroConta.text);
    final double? valorTransferencia =
        double.tryParse(_controladorCampoValor.text);
    if (numeroConta != null && valorTransferencia != null) {
      final Transferencia transferenciaCriada = Transferencia(
        numeroConta,
        valorTransferencia,
      );
      Navigator.pop(context, transferenciaCriada);
    }
  }
}
