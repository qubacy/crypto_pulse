import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';

import '../_common/LocalTokenEnvironmentDataSource.dart';

@Injectable(as: LocalTokenEnvironmentDataSource)
class LocalTokenEnvironmentDataSourceImpl extends LocalTokenEnvironmentDataSource {
  LocalTokenEnvironmentDataSourceImpl();

  @override
  Future<String> loadToken() {
    return Future.value(DotEnv().get(LocalTokenEnvironmentDataSource.TOKEN_ENV_PROP_NAME));
  }
}