import 'package:crypto_pulse/application/data/repository/crypto/_common/CryptoRepository.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/model/DataCrypto.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/RemoteCryptoHttpRestDataSource.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/local/database/_common/LocalCryptoDatabaseDataSource.dart';
import 'package:rxdart/rxdart.dart';

class CryptoRepositoryImpl implements CryptoRepository {
  @override
  late Stream<List<DataCrypto>> dataCryptoStream;

  @override
  LocalCryptoDatabaseDataSource localCryptoDatabaseDataSource;
  @override
  RemoteCryptoHttpRestDataSource remoteCryptoHttpRestDataSource;

  final BehaviorSubject<List<DataCrypto>> _cryptoStreamController = BehaviorSubject();

  CryptoRepositoryImpl({
    required this.localCryptoDatabaseDataSource, 
    required this.remoteCryptoHttpRestDataSource
  }) {
    dataCryptoStream = _cryptoStreamController.stream;
  }
  
  @override
  void loadCryptocurrencies(int count) async {
    final localCryptocurrencies = await localCryptoDatabaseDataSource.getCryptocurrencies(count);
    final localDataCryptocurrencies = localCryptocurrencies.map((item) => DataCrypto.fromLocalDatabase(item)).toList();
    // todo: seems overkilling:
    final localDataCryptocurrencyMap = Map.fromIterable(localDataCryptocurrencies, key: (item) => item.token, value: (item) => item);

    if (localCryptocurrencies.isNotEmpty) {
      _cryptoStreamController.add(localDataCryptocurrencies);
    }

    final remoteCryptocurrencies = await remoteCryptoHttpRestDataSource.getCryptocurrencies(count);
    final remoteDataCryptocurrencies = remoteCryptocurrencies.map(
      (item) => DataCrypto.fromRemoteHttpRest(remoteHttpRestCrypto: item, isFavorite: localDataCryptocurrencyMap[item.token])
    ).toList();

    if (!_compareDataCryptocurrencyLists(localDataCryptocurrencies, remoteDataCryptocurrencies)) {
      _cryptoStreamController.add(remoteDataCryptocurrencies);
    }
  }
  
  @override
  void addToFavorites(DataCrypto crypto) {
    // TODO: implement addToFavorites


  }
  
  @override
  void removeFromFavorites(DataCrypto crypto) {
    // TODO: implement removeFromFavorites


  }

  /// Strict comparison including order check;
  bool _compareDataCryptocurrencyLists(List<DataCrypto> left, List<DataCrypto> right) {
    final count = left.length;

    if (count != right.length) return false;

    for (int i = 0; i < count; ++i) {
      if (left[i] != right[i]) return false;
    }

    return true;
  }
}