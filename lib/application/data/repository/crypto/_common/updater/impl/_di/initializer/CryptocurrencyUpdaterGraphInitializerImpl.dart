import 'package:crypto_pulse/application/data/repository/crypto/_common/updater/_common/_di/initializer/CryptocurrencyUpdaterGraphInitializer.dart';
import 'package:injectable/injectable.dart';

import '../CryptocurrencyUpdaterGraph.dart';

@Injectable(as: CryptocurrencyUpdaterGraphInitializer)
class CryptocurrencyUpdaterGraphInitializerImpl implements CryptocurrencyUpdaterGraphInitializer {
  @override
  Future<void> initGraph(List<dynamic> args) async {
    if (args.length < 2) throw ArgumentError('\'args\' has to contain 2 elements!');

    await configureCryptocurrencyUpdaterDependecies(args[0], args[1]);
  }
}