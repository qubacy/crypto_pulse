abstract class LocalTokenEnvironmentDataSource {
  static const TOKEN_ENV_PROP_NAME = "ACCESS_TOKEN";

  Future<String> loadToken();
}