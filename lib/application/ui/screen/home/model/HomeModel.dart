import 'package:flutter/widgets.dart';

import '../../../_common/presentation/CryptoPresentation.dart';

mixin HomeModel implements ChangeNotifier {
  Stream<List<CryptoPresentation>> getFavoriteCryptoPresentations();
  void removeFromFavorites(CryptoPresentation crypto);
}