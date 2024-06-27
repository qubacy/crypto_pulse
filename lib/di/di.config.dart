// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:crypto_pulse/application/data/repository/_common/source/http/client/_di/HttpClientModule.dart'
    as _i29;
import 'package:crypto_pulse/application/data/repository/_common/source/http/context/_common/HttpContext.dart'
    as _i6;
import 'package:crypto_pulse/application/data/repository/_common/source/http/context/impl/HttpContextImpl.dart'
    as _i7;
import 'package:crypto_pulse/application/data/repository/_common/source/http/header/interceptor/authorization/_common/AuthorizationHttpHeaderInterceptor.dart'
    as _i10;
import 'package:crypto_pulse/application/data/repository/_common/source/http/header/interceptor/authorization/impl/AuthorizationHttpHeaderInterceptorImpl.dart'
    as _i11;
import 'package:crypto_pulse/application/data/repository/_common/source/local/database/_di/DatabaseModule.dart'
    as _i27;
import 'package:crypto_pulse/application/data/repository/_common/source/local/environment/_di/DotEnvModule.dart'
    as _i28;
import 'package:crypto_pulse/application/data/repository/crypto/_common/CryptoRepository.dart'
    as _i23;
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/api/_common/RemoteCryptoHttpRestDataSourceApi.dart'
    as _i15;
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/api/impl/RemoteCryptoHttpRestDataSourceApiImpl.dart'
    as _i16;
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/RemoteCryptoHttpRestDataSource.dart'
    as _i19;
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/impl/RemoteCryptoHttpRestDataSourceImpl.dart'
    as _i20;
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/local/database/_common/dao/_common/LocalCryptoDatabaseDataSourceDao.dart'
    as _i12;
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/local/database/_common/dao/impl/LocalCryptoDatabaseDataSourceDaoImpl.dart'
    as _i13;
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/local/database/_common/LocalCryptoDatabaseDataSource.dart'
    as _i17;
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/local/database/impl/LocalCryptoDatabaseDataSourceImpl.dart'
    as _i18;
import 'package:crypto_pulse/application/data/repository/crypto/_common/updater/_common/CryptocurrencyUpdater.dart'
    as _i21;
import 'package:crypto_pulse/application/data/repository/crypto/_common/updater/impl/CryptocurrencyUpdaterImpl.dart'
    as _i22;
import 'package:crypto_pulse/application/data/repository/crypto/impl/CryptoRepositoryImpl.dart'
    as _i24;
import 'package:crypto_pulse/application/data/repository/token/_common/source/local/environment/_common/LocalTokenEnvironmentDataSource.dart'
    as _i8;
import 'package:crypto_pulse/application/data/repository/token/_common/source/local/environment/impl/LocalTokenEnvironmentDataSourceImpl.dart'
    as _i9;
import 'package:crypto_pulse/application/ui/model/_common/AppModel.dart'
    as _i25;
import 'package:crypto_pulse/application/ui/model/impl/AppModelImpl.dart'
    as _i26;
import 'package:flutter_dotenv/flutter_dotenv.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i5;
import 'package:injectable/injectable.dart' as _i2;
import 'package:sqflite/sqflite.dart' as _i3;
import 'package:sqflite_common/sqlite_api.dart' as _i14;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final databaseModule = _$DatabaseModule();
    final dotEnvModule = _$DotEnvModule();
    final httpClientModule = _$HttpClientModule();
    await gh.factoryAsync<_i3.Database>(
      () => databaseModule.database,
      preResolve: true,
    );
    await gh.factoryAsync<_i4.DotEnv>(
      () => dotEnvModule.dotEnv(),
      preResolve: true,
    );
    gh.lazySingleton<_i5.Client>(() => httpClientModule.httpClient());
    gh.factory<_i6.HttpContext>(
        () => _i7.HttpContextImpl(dotEnv: gh<_i4.DotEnv>()));
    gh.factory<_i8.LocalTokenEnvironmentDataSource>(
        () => _i9.LocalTokenEnvironmentDataSourceImpl());
    gh.factory<_i10.AuthorizationHttpHeaderInterceptor>(() =>
        _i11.AuthorizationHttpHeaderInterceptorImpl(
            localTokenEnvironmentDataSource:
                gh<_i8.LocalTokenEnvironmentDataSource>()));
    gh.factory<_i12.LocalCryptoDatabaseDataSourceDao>(() =>
        _i13.LocalCryptoDatabaseDataSourceDaoImpl(
            database: gh<_i14.Database>()));
    gh.factory<_i15.RemoteCryptoHttpRestDataSourceApi>(
        () => _i16.RemoteCryptoHttpRestDataSourceApiImpl(
              httpClient: gh<_i5.Client>(),
              httpContext: gh<_i6.HttpContext>(),
              authorizationHttpHeaderInterceptor:
                  gh<_i10.AuthorizationHttpHeaderInterceptor>(),
            ));
    gh.factory<_i17.LocalCryptoDatabaseDataSource>(() =>
        _i18.LocalCryptoDatabaseDataSourceImpl(
            dao: gh<_i12.LocalCryptoDatabaseDataSourceDao>()));
    gh.factory<_i19.RemoteCryptoHttpRestDataSource>(() =>
        _i20.RemoteCryptoHttpRestDataSourceImpl(
            api: gh<_i15.RemoteCryptoHttpRestDataSourceApi>()));
    gh.factory<_i21.CryptocurrencyUpdater>(() => _i22.CryptocurrencyUpdaterImpl(
        remoteCryptoHttpRestDataSource:
            gh<_i19.RemoteCryptoHttpRestDataSource>()));
    gh.lazySingleton<_i23.CryptoRepository>(() => _i24.CryptoRepositoryImpl(
          localCryptoDatabaseDataSource:
              gh<_i17.LocalCryptoDatabaseDataSource>(),
          remoteCryptoHttpRestDataSource:
              gh<_i19.RemoteCryptoHttpRestDataSource>(),
          cryptocurrencyUpdater: gh<_i21.CryptocurrencyUpdater>(),
        ));
    gh.factory<_i25.AppModel>(
        () => _i26.AppModelImpl(gh<_i23.CryptoRepository>()));
    return this;
  }
}

class _$DatabaseModule extends _i27.DatabaseModule {}

class _$DotEnvModule extends _i28.DotEnvModule {}

class _$HttpClientModule extends _i29.HttpClientModule {}
