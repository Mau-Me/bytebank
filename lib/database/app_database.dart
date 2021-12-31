import 'dart:async';
import 'package:bytebank/models/transferencia.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String dbPath = await getDatabasesPath();
  final String path = join(dbPath, 'bytebank.db');
  return openDatabase(
    path,
    version: 1,
    onCreate: (Database db, int version) {
      db.execute('CREATE TABLE transferencia('
          'id INTEGER PRIMARY KEY, '
          'numero_conta INTEGER, '
          'valor_transferencia REAL)');
    },
    onDowngrade: onDatabaseDowngradeDelete,
  );
}

Future<int> save(Transferencia tranferencia) async {
  final Database db = await getDatabase();
  final Map<String, dynamic> transferenciaMap = {};
  transferenciaMap['numero_conta'] = tranferencia.numeroConta;
  transferenciaMap['valor_transferencia'] = tranferencia.valor;
  return db.insert('transferencia', transferenciaMap);
}

Future<List<Transferencia>> findAll() async {
  final Database db = await getDatabase();
  final List<Map<String, dynamic>> results = await db.query('transferencia');
  final List<Transferencia> transferencias = [];
  for (Map<String, dynamic> row in results) {
    final Transferencia transferencia = Transferencia(
      row['id'],
      row['numero_conta'],
      row['valor_transferencia'],
    );
    transferencias.add(transferencia);
  }
  return transferencias;
}
