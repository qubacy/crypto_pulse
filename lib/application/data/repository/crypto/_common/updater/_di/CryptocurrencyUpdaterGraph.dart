import 'package:crypto_pulse/application/data/repository/_common/source/http/client/_di/HttpClientModule.dart';
import 'package:crypto_pulse/application/data/repository/_common/source/http/context/_common/HttpContext.dart';
import 'package:crypto_pulse/application/data/repository/_common/source/http/context/updater/HttpContextUpdaterImpl.dart';
import 'package:crypto_pulse/application/data/repository/_common/source/http/header/interceptor/authorization/_common/AuthorizationHttpHeaderInterceptor.dart';
import 'package:crypto_pulse/application/data/repository/_common/source/http/header/interceptor/authorization/updater/AuthorizationHttpHeaderInterceptorUpdaterImpl.dart';
import 'package:crypto_pulse/application/data/repository/_common/source/local/environment/_di/DotEnvModule.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/RemoteCryptoHttpRestDataSource.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/api/_common/RemoteCryptoHttpRestDataSourceApi.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/api/impl/RemoteCryptoHttpRestDataSourceApiImpl.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/impl/RemoteCryptoHttpRestDataSourceImpl.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

final cryptocurrencyUpdaterGetIt = GetIt.instance;

class HttpClientModuleImpl extends HttpClientModule { }
class DotEnvModuleImpl extends DotEnvModule { }

Future<void> configureCryptocurrencyUpdaterDependecies(
  String baseUri,
  String accessToken
) async {
  final httpClientModule = HttpClientModuleImpl();

  cryptocurrencyUpdaterGetIt.registerLazySingleton<Client>(() => httpClientModule.httpClient());
  cryptocurrencyUpdaterGetIt.registerFactory<HttpContext>(() => HttpContextUpdaterImpl(baseUri: baseUri));
  cryptocurrencyUpdaterGetIt.registerFactory<AuthorizationHttpHeaderInterceptor>(() =>
    AuthorizationHttpHeaderInterceptorUpdaterImpl(token: accessToken)
  );
  cryptocurrencyUpdaterGetIt.registerFactory<RemoteCryptoHttpRestDataSourceApi>(() {
    final httpContext = cryptocurrencyUpdaterGetIt.get<HttpContext>();
    final authorizationHttpHeaderInterceptor = cryptocurrencyUpdaterGetIt.get<AuthorizationHttpHeaderInterceptor>();

    return RemoteCryptoHttpRestDataSourceApiImpl(
      httpClient: cryptocurrencyUpdaterGetIt.get(), 
      httpContext: httpContext, 
      authorizationHttpHeaderInterceptor: authorizationHttpHeaderInterceptor
    );
  });
  cryptocurrencyUpdaterGetIt.registerFactory<RemoteCryptoHttpRestDataSource>(() {
    final api = cryptocurrencyUpdaterGetIt.get<RemoteCryptoHttpRestDataSourceApi>();

    return RemoteCryptoHttpRestDataSourceImpl(api: api);
  });
}