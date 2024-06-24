// Mocks generated by Mockito 5.4.4 from annotations
// in crypto_pulse/test/application/data/repository/crypto/_common/source/local/database/impl/LocalCryptoDatabaseDataSourceImplTest.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:crypto_pulse/application/data/repository/crypto/_common/source/local/database/_common/dao/_common/entity/CryptoEntity.dart'
    as _i5;
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/local/database/_common/dao/_common/LocalCryptoDatabaseDataSourceDao.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:sqflite/sqflite.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeDatabase_0 extends _i1.SmartFake implements _i2.Database {
  _FakeDatabase_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [LocalCryptoDatabaseDataSourceDao].
///
/// See the documentation for Mockito's code generation for more information.
class MockLocalCryptoDatabaseDataSourceDao extends _i1.Mock
    implements _i3.LocalCryptoDatabaseDataSourceDao {
  MockLocalCryptoDatabaseDataSourceDao() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.Database get database => (super.noSuchMethod(
        Invocation.getter(#database),
        returnValue: _FakeDatabase_0(
          this,
          Invocation.getter(#database),
        ),
      ) as _i2.Database);

  @override
  set database(_i2.Database? _database) => super.noSuchMethod(
        Invocation.setter(
          #database,
          _database,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i4.Future<List<_i5.CryptoEntity>> getCryptocurrencies(int? count) =>
      (super.noSuchMethod(
        Invocation.method(
          #getCryptocurrencies,
          [count],
        ),
        returnValue:
            _i4.Future<List<_i5.CryptoEntity>>.value(<_i5.CryptoEntity>[]),
      ) as _i4.Future<List<_i5.CryptoEntity>>);

  @override
  _i4.Future<_i5.CryptoEntity?> getCryptocurrencyByToken(String? token) =>
      (super.noSuchMethod(
        Invocation.method(
          #getCryptocurrencyByToken,
          [token],
        ),
        returnValue: _i4.Future<_i5.CryptoEntity?>.value(),
      ) as _i4.Future<_i5.CryptoEntity?>);

  @override
  _i4.Future<void> saveCryptocurrencies(
          List<_i5.CryptoEntity>? cryptocurrencies) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveCryptocurrencies,
          [cryptocurrencies],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}
