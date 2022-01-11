import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:sqflite/sqflite.dart';

class TransferenciaDao {
  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_numeroConta INTEGER, '
      '$_valorTransferencia REAL)';

  static const String _tableName = 'transferencia';
  static const String _id = 'id';
  static const String _numeroConta = 'numero_conta';
  static const String _valorTransferencia = 'valor_transferencia';

  Future<int> save(Transferencia tranferencia) async {
    final Database db = await getDatabase(tableSql);
    Map<String, dynamic> transferenciaMap = _toMap(tranferencia);
    return db.insert(_tableName, transferenciaMap);
  }

  Future<List<Transferencia>> findAll() async {
    final Database db = await getDatabase(tableSql);
    final List<Map<String, dynamic>> results = await db.query(_tableName);
    List<Transferencia> transferencias = _toList(results);
    return transferencias;
  }

  Map<String, dynamic> _toMap(Transferencia tranferencia) {
    final Map<String, dynamic> transferenciaMap = {};
    transferenciaMap[_numeroConta] = tranferencia.numeroConta;
    transferenciaMap[_valorTransferencia] = tranferencia.valor;
    return transferenciaMap;
  }

  List<Transferencia> _toList(List<Map<String, dynamic>> results) {
    final List<Transferencia> transferencias = [];
    for (Map<String, dynamic> row in results) {
      final Transferencia transferencia = Transferencia(
        row[_id],
        row[_numeroConta],
        row[_valorTransferencia],
      );
      transferencias.add(transferencia);
    }
    return transferencias;
  }
}
