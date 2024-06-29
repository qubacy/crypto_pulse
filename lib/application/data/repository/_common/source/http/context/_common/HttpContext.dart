import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class HttpContext {
  static const String BASE_URI_ENV_PROP_NAME = "BASE_URI";

  late final DotEnv dotEnv;

  Future<String> loadUri();
}