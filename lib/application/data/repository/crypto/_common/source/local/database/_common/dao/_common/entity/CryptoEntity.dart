class CryptoEntity {
  static const String TABLE_NAME = "Cryptocurrency";

  static const String TOKEN_PROP_NAME = "token";
  static const String NAME_PROP_NAME = "name";
  static const String PRICE_PROP_NAME = "price";
  static const String IS_FAVORITE_PROP_NAME = "is_favorite";
  static const String CAPITALIZATION_PROP_NAME = "capitalization";

  static const String CREATE_TABLE_QUERY = 'CREATE TABLE $TABLE_NAME($TOKEN_PROP_NAME TEXT PRIMARY KEY, $NAME_PROP_NAME TEXT NOT NULL, $PRICE_PROP_NAME REAL NOT NULL, $IS_FAVORITE_PROP_NAME INT NOT NULL, $CAPITALIZATION_PROP_NAME REAL NOT NULL)';

  final String token;
  final String name;
  final double price;
  final bool isFavorite;
  final double capitalization;

  CryptoEntity({
    required this.token, 
    required this.name,
    required this.price,
    required this.isFavorite,
    required this.capitalization
  });

  factory CryptoEntity.fromMap(Map<String, dynamic> map) {
    final token = map[TOKEN_PROP_NAME] as String;
    final name = map[NAME_PROP_NAME] as String;
    final price = map[PRICE_PROP_NAME] as double;
    final isFavorite = (map[IS_FAVORITE_PROP_NAME] as int) == 0 ? false : true;
    final capitalization = map[CAPITALIZATION_PROP_NAME] as double;

    return CryptoEntity(
      token: token, 
      name: name, 
      price: price, 
      isFavorite: isFavorite, 
      capitalization: capitalization
    );
  }

  Map<String, dynamic> toMap() {
    return {
      TOKEN_PROP_NAME: token,
      NAME_PROP_NAME: name,
      PRICE_PROP_NAME: price,
      IS_FAVORITE_PROP_NAME: isFavorite ? 1 : 0,
      CAPITALIZATION_PROP_NAME: capitalization
    };
  }
}