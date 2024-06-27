import 'package:crypto_pulse/application/data/repository/_common/source/http/client/_di/HttpClientModule.dart';
import 'package:crypto_pulse/application/data/repository/_common/source/http/context/_common/HttpContext.dart';
import 'package:crypto_pulse/application/data/repository/_common/source/http/context/impl/HttpContextImpl.dart';
import 'package:crypto_pulse/application/data/repository/_common/source/http/header/interceptor/authorization/_common/AuthorizationHttpHeaderInterceptor.dart';
import 'package:crypto_pulse/application/data/repository/_common/source/http/header/interceptor/authorization/impl/AuthorizationHttpHeaderInterceptorImpl.dart';
import 'package:crypto_pulse/application/data/repository/_common/source/local/environment/_di/DotEnvModule.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/RemoteCryptoHttpRestDataSource.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/api/_common/RemoteCryptoHttpRestDataSourceApi.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/api/impl/RemoteCryptoHttpRestDataSourceApiImpl.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/impl/RemoteCryptoHttpRestDataSourceImpl.dart';
import 'package:crypto_pulse/application/data/repository/token/_common/source/local/environment/_common/LocalTokenEnvironmentDataSource.dart';
import 'package:crypto_pulse/application/data/repository/token/_common/source/local/environment/impl/LocalTokenEnvironmentDataSourceImpl.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

final cryptocurrencyUpdaterGetIt = GetIt.instance;

class HttpClientModuleImpl extends HttpClientModule { }
class DotEnvModuleImpl extends DotEnvModule { }

Future<void> configureCryptocurrencyUpdaterDependecies() async {
  final httpClientModule = HttpClientModuleImpl();
  final dotEnvModule = DotEnvModuleImpl();

  cryptocurrencyUpdaterGetIt.registerFactoryAsync(() => dotEnvModule.dotEnv());
  cryptocurrencyUpdaterGetIt.registerLazySingleton<Client>(() => httpClientModule.httpClient());
  cryptocurrencyUpdaterGetIt.registerFactoryAsync<HttpContext>(() async {
    final dotEnv = await cryptocurrencyUpdaterGetIt.getAsync<DotEnv>();

    return HttpContextImpl(dotEnv: dotEnv);
  });
  cryptocurrencyUpdaterGetIt.registerFactory<LocalTokenEnvironmentDataSource>(() => LocalTokenEnvironmentDataSourceImpl(dotEnv: cryptocurrencyUpdaterGetIt.get()));
  cryptocurrencyUpdaterGetIt.registerFactory<AuthorizationHttpHeaderInterceptor>(
    () => AuthorizationHttpHeaderInterceptorImpl(localTokenEnvironmentDataSource: cryptocurrencyUpdaterGetIt.get())
  );
  cryptocurrencyUpdaterGetIt.registerFactory<RemoteCryptoHttpRestDataSourceApi>(
    () => RemoteCryptoHttpRestDataSourceApiImpl(
      httpClient: cryptocurrencyUpdaterGetIt.get(), 
      httpContext: cryptocurrencyUpdaterGetIt.get(), 
      authorizationHttpHeaderInterceptor: cryptocurrencyUpdaterGetIt.get()
    )
  );
  cryptocurrencyUpdaterGetIt.registerFactory<RemoteCryptoHttpRestDataSource>(() => RemoteCryptoHttpRestDataSourceImpl(api: cryptocurrencyUpdaterGetIt.get()));
}