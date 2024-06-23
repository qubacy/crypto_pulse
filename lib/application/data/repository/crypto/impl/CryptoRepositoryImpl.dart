import 'package:crypto_pulse/application/data/repository/crypto/_common/CryptoRepository.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/model/DataCrypto.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/RemoteCryptoHttpRestDataSource.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/model/RemoteHttpRestCrypto.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/local/database/_common/LocalCryptoDatabaseDataSource.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/updater/_common/CryptocurrencyUpdater.dart';
import 'package:rxdart/rxdart.dart';

class CryptoRepositoryImpl implements CryptoRepository, CryptocurrencyUpdaterCallback {
  @override
  late Stream<List<DataCrypto>> dataCryptoStream;

  @override
  LocalCryptoDatabaseDataSource localCryptoDatabaseDataSource;
  @override
  RemoteCryptoHttpRestDataSource remoteCryptoHttpRestDataSource;
  @override
  CryptocurrencyUpdater cryptocurrencyUpdater;

  final BehaviorSubject<List<DataCrypto>> _cryptoStreamController = BehaviorSubject();

  CryptoRepositoryImpl({
    required this.localCryptoDatabaseDataSource, 
    required this.remoteCryptoHttpRestDataSource,
    required this.cryptocurrencyUpdater
  }) {
    dataCryptoStream = _cryptoStreamController.stream.asBroadcastStream();

    cryptocurrencyUpdater.setCallback(this);
  }
  
  @override
  Future<void> loadCryptocurrencies(int count) async {
    await _retrieveCryptocurrencies(count);
    _startCryptocurrencyUpdater(count);
  }

  Future<void> _retrieveCryptocurrencies(int count, {List<RemoteHttpRestCrypto>? gottenRemoteCryptocurrencies}) async {
    final localCryptocurrencies = await localCryptoDatabaseDataSource.getCryptocurrencies(count);
    final localDataCryptocurrencies = localCryptocurrencies.map((item) => DataCrypto.fromLocalDatabase(item)).toList();
    // todo: seems overkilling:
    final localDataCryptocurrencyMap = Map.fromIterable(
      localDataCryptocurrencies, key: (item) => item.token, value: (item) => item
    );

    if (localCryptocurrencies.isNotEmpty) {
      _cryptoStreamController.add(localDataCryptocurrencies);
    }

    final remoteCryptocurrencies = gottenRemoteCryptocurrencies ?? await remoteCryptoHttpRestDataSource.getCryptocurrencies(count);
    final remoteDataCryptocurrencies = remoteCryptocurrencies.map(
      (item) => DataCrypto.fromRemoteHttpRest(remoteHttpRestCrypto: item, isFavorite: localDataCryptocurrencyMap[item.token]?.isFavorite)
    ).toList();

    if (!_compareDataCryptocurrencyLists(localDataCryptocurrencies, remoteDataCryptocurrencies)) {
      _cryptoStreamController.add(remoteDataCryptocurrencies);

      final cryptocurrenciesToSave = remoteDataCryptocurrencies.map((item) => item.toLocalDatabase()).toList();

      localCryptoDatabaseDataSource.saveCryptocurrencies(cryptocurrenciesToSave);
    }
  }
  
  @override
  void addToFavorites(DataCrypto crypto) {
    _changeFavoriteState(crypto);
  }
  
  @override
  void removeFromFavorites(DataCrypto crypto) {
    _changeFavoriteState(crypto);
  }

  // todo: is it alright?:
  void _changeFavoriteState(DataCrypto crypto) {
    final localDatabaseCrypto = crypto.toLocalDatabase(newIsFavorite: !crypto.isFavorite);

    localCryptoDatabaseDataSource.saveCryptocurrencies([localDatabaseCrypto]);
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

  void _startCryptocurrencyUpdater(int count) {
    cryptocurrencyUpdater.start(count);
  }
  
  @override
  void onCryptocurrenciesGotten(int count, List<RemoteHttpRestCrypto> cryptocurrencies) {
    _retrieveCryptocurrencies(count, gottenRemoteCryptocurrencies: cryptocurrencies);
  }
}