class PercentChange {
  final double hour;
  final double day;
  final double week;
  final double month;
  final double year;
  final double all;

  PercentChange(
      {required this.hour,
      required this.day,
      required this.week,
      required this.month,
      required this.year,
      required this.all});

  factory PercentChange.fromJson(Map<String, dynamic> json) {
    final double hour = json['hour'] as double;
    final double day = json['day'] as double;
    final double week = json['week'] as double;
    final double month = json['month'] as double;
    final double year = json['year'] as double;
    final double all = json['all'] as double;
    return PercentChange(
        hour: hour, day: day, week: week, month: month, all: all, year: year);
  }

  Map<String, dynamic> toJson() {
    return {
      'hour': hour,
      'day': day,
      'week': week,
      'month': month,
      'all': all,
      'year': year
    };
  }
}
