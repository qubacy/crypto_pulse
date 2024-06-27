
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';

@module
abstract class HttpClientModule {
  @lazySingleton
  Client httpClient() => Client();
}