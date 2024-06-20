import 'package:crypto_pulse/application/data/repository/crypto/_common/model/DataCrypto.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/model/RemoteHttpRestCrypto.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/local/database/_common/model/LocalDatabaseCrypto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Data Crypto tests', () {
    test('operator==() on different objects test', () {
      const DataCrypto right = DataCrypto(
        token: 'test 1', 
        name: 'test 1', 
        price: 1, 
        capitalization: 1, 
        isFavorite: true
      );
      const DataCrypto left = DataCrypto(
        token: 'test 2', 
        name: 'test 2', 
        price: 2, 
        capitalization: 2, 
        isFavorite: true
      );

      const expectedAreEqual = false;
      final bool gottenAreEqual = (left == right);

      expect(gottenAreEqual, expectedAreEqual);
    });

    test('operator==() on equal objects test', () {
      const DataCrypto right = DataCrypto(
        token: 'test 1', 
        name: 'test 1', 
        price: 1, 
        capitalization: 1, 
        isFavorite: true
      );
      const DataCrypto left = DataCrypto(
        token: 'test 1', 
        name: 'test 1', 
        price: 1, 
        capitalization: 1, 
        isFavorite: true
      );

      const expectedAreEqual = true;
      final bool gottenAreEqual = (left == right);

      expect(gottenAreEqual, expectedAreEqual);
    });

    test('fromLocalDatabase() test', () {
      const LocalDatabaseCrypto localDatabaseCrypto = LocalDatabaseCrypto(
        token: 'test', name: 'test', price: 0, isFavorite: true, capitalization: 0
      );

      final DataCrypto expectedDataCrypto = DataCrypto(
        token: localDatabaseCrypto.token,
        name: localDatabaseCrypto.name, 
        price: localDatabaseCrypto.price, 
        capitalization: localDatabaseCrypto.capitalization, 
        isFavorite: localDatabaseCrypto.isFavorite
      );

      final gottenDataCrypto = DataCrypto.fromLocalDatabase(localDatabaseCrypto);

      expect(gottenDataCrypto, expectedDataCrypto);
    });

    test('fromLocalDatabase() test', () {
      const LocalDatabaseCrypto localDatabaseCrypto = LocalDatabaseCrypto(
        token: 'test', name: 'test', price: 0, isFavorite: true, capitalization: 0
      );

      final DataCrypto expectedDataCrypto = DataCrypto(
        token: localDatabaseCrypto.token,
        name: localDatabaseCrypto.name, 
        price: localDatabaseCrypto.price, 
        capitalization: localDatabaseCrypto.capitalization, 
        isFavorite: localDatabaseCrypto.isFavorite
      );

      final gottenDataCrypto = DataCrypto.fromLocalDatabase(localDatabaseCrypto);

      expect(gottenDataCrypto, expectedDataCrypto);
    });

    test('toLocalDatabase() test', () {
      const DataCrypto dataCrypto = DataCrypto(
        token: 'test', name: 'test', price: 0, isFavorite: true, capitalization: 0
      );

      final LocalDatabaseCrypto expectedLocalDatabaseCrypto = LocalDatabaseCrypto(
        token: dataCrypto.token,
        name: dataCrypto.name, 
        price: dataCrypto.price, 
        capitalization: dataCrypto.capitalization, 
        isFavorite: dataCrypto.isFavorite
      );

      final gottenLocalDatabaseCrypto = dataCrypto.toLocalDatabase();

      expect(gottenLocalDatabaseCrypto, expectedLocalDatabaseCrypto);
    });

    test('fromRemoteHttpRest() test', () {
      const RemoteHttpRestCrypto remoteHttpRestCrypto = RemoteHttpRestCrypto(
        token: 'test', name: 'test', price: 0, capitalization: 0
      );
      const isFavorite = false;

      final DataCrypto expectedDataCrypto = DataCrypto(
        token: remoteHttpRestCrypto.token,
        name: remoteHttpRestCrypto.name, 
        price: remoteHttpRestCrypto.price, 
        capitalization: remoteHttpRestCrypto.capitalization, 
        isFavorite: isFavorite
      );

      final gottenDataCrypto = DataCrypto.fromRemoteHttpRest(
        remoteHttpRestCrypto: remoteHttpRestCrypto, isFavorite: isFavorite
      );

      expect(gottenDataCrypto, expectedDataCrypto);
    });
  });
}