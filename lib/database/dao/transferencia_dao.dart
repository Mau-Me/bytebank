import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:sqflite/sqflite.dart';

class TransferenciaDao {
  static const String tableSql = 'CREATE TABLE transferencia('
      'id INTEGER PRIMARY KEY, '
      'numero_conta INTEGER, '
      'valor_transferencia REAL)';

  Future<int> save(Transferencia tranferencia) async {
    final Database db = await getDatabase(tableSql);
    final Map<String, dynamic> transferenciaMap = {};
    transferenciaMap['numero_conta'] = tranferencia.numeroConta;
    transferenciaMap['valor_transferencia'] = tranferencia.valor;
    return db.insert('transferencia', transferenciaMap);
  }

  Future<List<Transferencia>> findAll() async {
    final Database db = await getDatabase(tableSql);
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
}
