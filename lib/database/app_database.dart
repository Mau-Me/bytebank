import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase(String tableSql) async {
  final String dbPath = await getDatabasesPath();
  final String path = join(dbPath, 'bytebank.db');
  return openDatabase(
    path,
    version: 1,
    onCreate: (Database db, int version) {
      db.execute(tableSql);
    },
    onDowngrade: onDatabaseDowngradeDelete,
  );
}
