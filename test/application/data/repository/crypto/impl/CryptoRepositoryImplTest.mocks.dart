// Mocks generated by Mockito 5.4.4 from annotations
// in crypto_pulse/test/application/data/repository/crypto/impl/CryptoRepositoryImplTest.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/api/_common/RemoteCryptoHttpRestDataSourceApi.dart'
    as _i3;
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/model/RemoteHttpRestCrypto.dart'
    as _i9;
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/RemoteCryptoHttpRestDataSource.dart'
    as _i8;
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/local/database/_common/dao/_common/LocalCryptoDatabaseDataSourceDao.dart'
    as _i2;
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/local/database/_common/LocalCryptoDatabaseDataSource.dart'
    as _i5;
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/local/database/_common/model/LocalDatabaseCrypto.dart'
    as _i7;
import 'package:crypto_pulse/application/data/repository/crypto/_common/updater/_common/CryptocurrencyUpdater.dart'
    as _i4;
import 'package:mockito/mockito.dart' as _i1;

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

class _FakeLocalCryptoDatabaseDataSourceDao_0 extends _i1.SmartFake
    implements _i2.LocalCryptoDatabaseDataSourceDao {
  _FakeLocalCryptoDatabaseDataSourceDao_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeRemoteCryptoHttpRestDataSourceApi_1 extends _i1.SmartFake
    implements _i3.RemoteCryptoHttpRestDataSourceApi {
  _FakeRemoteCryptoHttpRestDataSourceApi_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeCryptocurrencyUpdaterCallback_2 extends _i1.SmartFake
    implements _i4.CryptocurrencyUpdaterCallback {
  _FakeCryptocurrencyUpdaterCallback_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [LocalCryptoDatabaseDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockLocalCryptoDatabaseDataSource extends _i1.Mock
    implements _i5.LocalCryptoDatabaseDataSource {
  MockLocalCryptoDatabaseDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.LocalCryptoDatabaseDataSourceDao get dao => (super.noSuchMethod(
        Invocation.getter(#dao),
        returnValue: _FakeLocalCryptoDatabaseDataSourceDao_0(
          this,
          Invocation.getter(#dao),
        ),
      ) as _i2.LocalCryptoDatabaseDataSourceDao);

  @override
  set dao(_i2.LocalCryptoDatabaseDataSourceDao? _dao) => super.noSuchMethod(
        Invocation.setter(
          #dao,
          _dao,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i6.Future<List<_i7.LocalDatabaseCrypto>> getCryptocurrencies(int? count) =>
      (super.noSuchMethod(
        Invocation.method(
          #getCryptocurrencies,
          [count],
        ),
        returnValue: _i6.Future<List<_i7.LocalDatabaseCrypto>>.value(
            <_i7.LocalDatabaseCrypto>[]),
      ) as _i6.Future<List<_i7.LocalDatabaseCrypto>>);

  @override
  _i6.Future<void> saveCryptocurrencies(
          List<_i7.LocalDatabaseCrypto>? cryptocurrencies) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveCryptocurrencies,
          [cryptocurrencies],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
}

/// A class which mocks [RemoteCryptoHttpRestDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoteCryptoHttpRestDataSource extends _i1.Mock
    implements _i8.RemoteCryptoHttpRestDataSource {
  MockRemoteCryptoHttpRestDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.RemoteCryptoHttpRestDataSourceApi get api => (super.noSuchMethod(
        Invocation.getter(#api),
        returnValue: _FakeRemoteCryptoHttpRestDataSourceApi_1(
          this,
          Invocation.getter(#api),
        ),
      ) as _i3.RemoteCryptoHttpRestDataSourceApi);

  @override
  set api(_i3.RemoteCryptoHttpRestDataSourceApi? _api) => super.noSuchMethod(
        Invocation.setter(
          #api,
          _api,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i6.Future<List<_i9.RemoteHttpRestCrypto>> getCryptocurrencies(int? count) =>
      (super.noSuchMethod(
        Invocation.method(
          #getCryptocurrencies,
          [count],
        ),
        returnValue: _i6.Future<List<_i9.RemoteHttpRestCrypto>>.value(
            <_i9.RemoteHttpRestCrypto>[]),
      ) as _i6.Future<List<_i9.RemoteHttpRestCrypto>>);
}

/// A class which mocks [CryptocurrencyUpdater].
///
/// See the documentation for Mockito's code generation for more information.
class MockCryptocurrencyUpdater extends _i1.Mock
    implements _i4.CryptocurrencyUpdater {
  MockCryptocurrencyUpdater() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.CryptocurrencyUpdaterCallback get callback => (super.noSuchMethod(
        Invocation.getter(#callback),
        returnValue: _FakeCryptocurrencyUpdaterCallback_2(
          this,
          Invocation.getter(#callback),
        ),
      ) as _i4.CryptocurrencyUpdaterCallback);

  @override
  void setCallback(_i4.CryptocurrencyUpdaterCallback? callback) =>
      super.noSuchMethod(
        Invocation.method(
          #setCallback,
          [callback],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void start(int? count) => super.noSuchMethod(
        Invocation.method(
          #start,
          [count],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void stop() => super.noSuchMethod(
        Invocation.method(
          #stop,
          [],
        ),
        returnValueForMissingStub: null,
      );
}