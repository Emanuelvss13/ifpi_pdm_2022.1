class FavoritedCripto {
  late String id;
  late String name;
  late String symbol;
  late String image_url;

  FavoritedCripto(
      {required String id,
      required String name,
      required String symbol,
      required String image_url});

  factory FavoritedCripto.fromDatabase(dynamic object) {
    return FavoritedCripto(
        id: object['id'],
        name: object['name'],
        symbol: object['symbol'],
        image_url: object['image_url']);
  }
}
