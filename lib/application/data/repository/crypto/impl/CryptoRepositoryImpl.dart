import 'package:crypto_pulse/application/data/repository/crypto/_common/CryptoRepository.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/model/DataCrypto.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/RemoteCryptoHttpRestDataSource.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/model/RemoteHttpRestCrypto.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/local/database/_common/LocalCryptoDatabaseDataSource.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/updater/_common/CryptocurrencyUpdater.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@LazySingleton(as: CryptoRepository)
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

    if (localCryptocurrencies.isNotEmpty && gottenRemoteCryptocurrencies == null) {
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
  Future<void> addToFavorites(String cryptoToken) async {
    await _changeFavoriteState(cryptoToken, true);
  }
  
  @override
  Future<void> removeFromFavorites(String cryptoToken) async {
    await _changeFavoriteState(cryptoToken, false);
  }

  Future<void> _changeFavoriteState(String cryptoToken, bool isFavorite) async {
    final localDatabaseCrypto = await localCryptoDatabaseDataSource.getCryptocurrencyByToken(cryptoToken); //crypto.toLocalDatabase(newIsFavorite: isFavorite);
    
    if (localDatabaseCrypto == null) throw Exception();

    final localDatabaseCryptoToSave = localDatabaseCrypto.copyWith(newIsFavorite: isFavorite);

    await localCryptoDatabaseDataSource.saveCryptocurrencies([localDatabaseCryptoToSave]);
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
  Future<void> onCryptocurrenciesGotten(int count, List<RemoteHttpRestCrypto> cryptocurrencies) async {
    await _retrieveCryptocurrencies(count, gottenRemoteCryptocurrencies: cryptocurrencies);
  }
}