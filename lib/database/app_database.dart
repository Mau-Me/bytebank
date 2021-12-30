import 'dart:async';
import 'package:bytebank/models/transferencia.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> createDatabase() {
  return getDatabasesPath().then((String dbPath) {
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
  });
}

Future<int> save(Transferencia tranferencia) {
  return createDatabase().then((Database db) {
    final Map<String, dynamic> transferenciaMap = {};
    transferenciaMap['numero_conta'] = tranferencia.numeroConta;
    transferenciaMap['valor_transferencia'] = tranferencia.valor;
    return db.insert('transferencia', transferenciaMap);
  });
}

Future<List<Transferencia>> findAll() {
  return createDatabase().then((db) {
    return db.query('transferencia').then((maps) {
      final List<Transferencia> transferencias = [];
      for (Map<String, dynamic> map in maps) {
        final Transferencia transferencia = Transferencia(
          map['id'],
          map['numero_conta'],
          map['valor_transferencia'],
        );
        transferencias.add(transferencia);
      }
      return transferencias;
    });
  });
}
