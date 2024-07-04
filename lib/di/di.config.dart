// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:crypto_pulse/application/data/repository/_common/source/http/client/_di/HttpClientModule.dart'
    as _i35;
import 'package:crypto_pulse/application/data/repository/_common/source/http/context/_common/HttpContext.dart'
    as _i6;
import 'package:crypto_pulse/application/data/repository/_common/source/http/context/impl/HttpContextImpl.dart'
    as _i7;
import 'package:crypto_pulse/application/data/repository/_common/source/http/header/interceptor/authorization/_common/AuthorizationHttpHeaderInterceptor.dart'
    as _i12;
import 'package:crypto_pulse/application/data/repository/_common/source/http/header/interceptor/authorization/impl/AuthorizationHttpHeaderInterceptorImpl.dart'
    as _i13;
import 'package:crypto_pulse/application/data/repository/_common/source/local/database/_di/DatabaseModule.dart'
    as _i33;
import 'package:crypto_pulse/application/data/repository/_common/source/local/environment/_di/DotEnvModule.dart'
    as _i34;
import 'package:crypto_pulse/application/data/repository/crypto/_common/CryptoRepository.dart'
    as _i25;
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/api/_common/RemoteCryptoHttpRestDataSourceApi.dart'
    as _i17;
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/api/impl/RemoteCryptoHttpRestDataSourceApiImpl.dart'
    as _i18;
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/RemoteCryptoHttpRestDataSource.dart'
    as _i21;
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/impl/RemoteCryptoHttpRestDataSourceImpl.dart'
    as _i22;
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/local/database/_common/dao/_common/LocalCryptoDatabaseDataSourceDao.dart'
    as _i14;
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/local/database/_common/dao/impl/LocalCryptoDatabaseDataSourceDaoImpl.dart'
    as _i15;
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/local/database/_common/LocalCryptoDatabaseDataSource.dart'
    as _i19;
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/local/database/impl/LocalCryptoDatabaseDataSourceImpl.dart'
    as _i20;
import 'package:crypto_pulse/application/data/repository/crypto/_common/updater/_common/_di/initializer/CryptocurrencyUpdaterGraphInitializer.dart'
    as _i10;
import 'package:crypto_pulse/application/data/repository/crypto/_common/updater/_common/CryptocurrencyUpdater.dart'
    as _i23;
import 'package:crypto_pulse/application/data/repository/crypto/_common/updater/impl/_di/initializer/CryptocurrencyUpdaterGraphInitializerImpl.dart'
    as _i11;
import 'package:crypto_pulse/application/data/repository/crypto/_common/updater/impl/CryptocurrencyUpdaterImpl.dart'
    as _i24;
import 'package:crypto_pulse/application/data/repository/crypto/impl/CryptoRepositoryImpl.dart'
    as _i26;
import 'package:crypto_pulse/application/data/repository/token/_common/source/local/environment/_common/LocalTokenEnvironmentDataSource.dart'
    as _i8;
import 'package:crypto_pulse/application/data/repository/token/_common/source/local/environment/impl/LocalTokenEnvironmentDataSourceImpl.dart'
    as _i9;
import 'package:crypto_pulse/application/ui/model/_common/AppModel.dart'
    as _i31;
import 'package:crypto_pulse/application/ui/model/impl/AppModelImpl.dart'
    as _i32;
import 'package:crypto_pulse/application/ui/screen/cryptocurrency/model/_common/CryptocurrenciesModel.dart'
    as _i29;
import 'package:crypto_pulse/application/ui/screen/cryptocurrency/model/impl/CryptocurrenciesModelImpl.dart'
    as _i30;
import 'package:crypto_pulse/application/ui/screen/home/model/_common/HomeModel.dart'
    as _i27;
import 'package:crypto_pulse/application/ui/screen/home/model/impl/HomeModelImpl.dart'
    as _i28;
import 'package:flutter_dotenv/flutter_dotenv.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i5;
import 'package:injectable/injectable.dart' as _i2;
import 'package:sqflite/sqflite.dart' as _i3;
import 'package:sqflite_common/sqlite_api.dart' as _i16;

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
    gh.factory<_i8.LocalTokenEnvironmentDataSource>(() =>
        _i9.LocalTokenEnvironmentDataSourceImpl(dotEnv: gh<_i4.DotEnv>()));
    gh.factory<_i10.CryptocurrencyUpdaterGraphInitializer>(
        () => _i11.CryptocurrencyUpdaterGraphInitializerImpl());
    gh.factory<_i12.AuthorizationHttpHeaderInterceptor>(() =>
        _i13.AuthorizationHttpHeaderInterceptorImpl(
            localTokenEnvironmentDataSource:
                gh<_i8.LocalTokenEnvironmentDataSource>()));
    gh.factory<_i14.LocalCryptoDatabaseDataSourceDao>(() =>
        _i15.LocalCryptoDatabaseDataSourceDaoImpl(
            database: gh<_i16.Database>()));
    gh.factory<_i17.RemoteCryptoHttpRestDataSourceApi>(
        () => _i18.RemoteCryptoHttpRestDataSourceApiImpl(
              httpClient: gh<_i5.Client>(),
              httpContext: gh<_i6.HttpContext>(),
              authorizationHttpHeaderInterceptor:
                  gh<_i12.AuthorizationHttpHeaderInterceptor>(),
            ));
    gh.factory<_i19.LocalCryptoDatabaseDataSource>(() =>
        _i20.LocalCryptoDatabaseDataSourceImpl(
            dao: gh<_i14.LocalCryptoDatabaseDataSourceDao>()));
    gh.factory<_i21.RemoteCryptoHttpRestDataSource>(() =>
        _i22.RemoteCryptoHttpRestDataSourceImpl(
            api: gh<_i17.RemoteCryptoHttpRestDataSourceApi>()));
    gh.factory<_i23.CryptocurrencyUpdater>(() => _i24.CryptocurrencyUpdaterImpl(
          remoteCryptoHttpRestDataSource:
              gh<_i21.RemoteCryptoHttpRestDataSource>(),
          localTokenEnvironmentDataSource:
              gh<_i8.LocalTokenEnvironmentDataSource>(),
          httpContext: gh<_i6.HttpContext>(),
          cryptocurrencyUpdaterGraphInitializer:
              gh<_i10.CryptocurrencyUpdaterGraphInitializer>(),
        ));
    gh.lazySingleton<_i25.CryptoRepository>(() => _i26.CryptoRepositoryImpl(
          localCryptoDatabaseDataSource:
              gh<_i19.LocalCryptoDatabaseDataSource>(),
          remoteCryptoHttpRestDataSource:
              gh<_i21.RemoteCryptoHttpRestDataSource>(),
          cryptocurrencyUpdater: gh<_i23.CryptocurrencyUpdater>(),
        ));
    gh.factory<_i27.HomeModel>(
        () => _i28.HomeModelImpl(gh<_i25.CryptoRepository>()));
    gh.factory<_i29.CryptocurrenciesModel>(
        () => _i30.CryptocurrenciesModelImpl(gh<_i25.CryptoRepository>()));
    gh.factory<_i31.AppModel>(
        () => _i32.AppModelImpl(gh<_i25.CryptoRepository>()));
    return this;
  }
}

class _$DatabaseModule extends _i33.DatabaseModule {}

class _$DotEnvModule extends _i34.DotEnvModule {}

class _$HttpClientModule extends _i35.HttpClientModule {}
