import 'package:crypto_pulse/application/data/repository/crypto/_common/source/local/database/_common/dao/_common/entity/CryptoEntity.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static const String DATABASE_NAME = "database.db";

  static final DatabaseProvider instance = DatabaseProvider._();

  static late Database _database;
  Future<Database> get database async {
    _database ??= await _initDatabase();

    return _database;
  }

  DatabaseProvider._();

  Future<Database> _initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), DATABASE_NAME),
      onCreate: (database, version) => _createDatabase(database),
      version: 1
    );
  }

  Future<void> _createDatabase(Database database) async {
    return database.execute(
      CryptoEntity.CREATE_TABLE_QUERY
    );
  }
}