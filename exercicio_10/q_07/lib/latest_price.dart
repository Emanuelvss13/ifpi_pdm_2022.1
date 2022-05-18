import 'package:q_07/amount.dart';
import 'package:q_07/percent_change.dart';

class LatestPrice {
  final String timestamp;
  final Amount amount;
  final PercentChange percentChange;

  LatestPrice(
      {required this.percentChange,
      required this.timestamp,
      required this.amount});

  factory LatestPrice.fromJson(Map<String, dynamic> json) {
    final timestamp = json['timestamp'] as String;
    final amount = Amount.fromJson(json['amount']);
    final percentChange = PercentChange.fromJson(json['percent_change']);
    return LatestPrice(
        timestamp: timestamp, amount: amount, percentChange: percentChange);
  }

  Map<String, dynamic> toJson() {
    return {
      'timestamp': timestamp,
      'amount': amount,
      'percentChange': percentChange
    };
  }
}
