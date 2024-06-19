import 'package:crypto_pulse/application/data/repository/_common/source/http/context/_common/HttpContext.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HttpContextImpl extends HttpContext {
  HttpContextImpl() {
    baseUri = DotEnv().env[HttpContext.BASE_URI_ENV_PROP_NAME]!;
  }
}