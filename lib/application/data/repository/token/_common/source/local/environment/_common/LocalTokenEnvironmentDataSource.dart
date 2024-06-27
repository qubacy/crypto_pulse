import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class LocalTokenEnvironmentDataSource {
  static const TOKEN_ENV_PROP_NAME = "ACCESS_TOKEN";

  late DotEnv dotEnv;

  Future<String> loadToken();
}