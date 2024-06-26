import 'package:crypto_pulse/application/data/repository/_common/source/http/context/_common/HttpContext.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HttpContext)
class HttpContextImpl extends HttpContext {
  HttpContextImpl({required DotEnv dotEnv}) {
    super.dotEnv = dotEnv;
  }
  
  @override
  Future<String> loadUri() async {
    return dotEnv.env[HttpContext.BASE_URI_ENV_PROP_NAME]!;
  }
}