import 'package:crypto_pulse/application/data/repository/_common/source/local/database/provider/DatabaseProvider.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/local/database/_common/dao/_common/entity/CryptoEntity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  const GET_TABLE_QUERY_TEMPLATE = 'SELECT * FROM %';

  TestWidgetsFlutterBinding.ensureInitialized();

  group('Database Provider tests', () {
    test('Database getter with initialization test', () async {
      final database = await DatabaseProvider.instance.database;

      const expectedDatabaseVersion = 1;
      const expectedTables = [CryptoEntity.TABLE_NAME];

      expect(database, isNotNull);
      expect(database.isOpen, isTrue);

      final gottenDatabaseVersion = await database.getVersion();

      expect(gottenDatabaseVersion, expectedDatabaseVersion);

      for (String expectedTable in expectedTables)
        await database.rawQuery('SELECT * FROM $expectedTable');
    });
  }); 
}