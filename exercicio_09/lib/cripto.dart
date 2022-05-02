import 'package:exercicio_07/latest_price.dart';
import 'package:exercicio_07/percent_change.dart';

class Cripto {
  final String id;
  final String name;
  final String imageUrl;
  final String symbol;
  final double percentChange;
  final String? description;
  final String marketCap;
  final String color;
  final int rank;
  final LatestPrice latestPrice;
  final String volume24h;

  const Cripto(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.symbol,
      required this.percentChange,
      required this.description,
      required this.marketCap,
      required this.color,
      required this.rank,
      required this.latestPrice,
      required this.volume24h});

  factory Cripto.fromJson(Map<String, dynamic> json) {
    final latestPriceData = json['latest_price'] as Map<String, dynamic>;
    return Cripto(
        id: json['id'],
        name: json['name'],
        imageUrl: json['image_url'],
        symbol: json['symbol'],
        percentChange: json['percent_change'],
        description: json['description'],
        marketCap: json['market_cap'],
        color: json['color'],
        rank: json['rank'],
        volume24h: json['volume_24h'],
        latestPrice: LatestPrice.fromJson(latestPriceData));
  }
}
