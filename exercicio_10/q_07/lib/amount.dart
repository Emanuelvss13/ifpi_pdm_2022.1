class Amount {
  final String amount;
  final String currency;
  final String scale;

  Amount({required this.amount, required this.currency, required this.scale});

  factory Amount.fromJson(Map<String, dynamic> json) {
    final amount = json['amount'] as String;
    final currency = json['currency'] as String;
    final scale = json['scale'] as String;
    return Amount(currency: currency, amount: amount, scale: scale);
  }
}
