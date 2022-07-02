// ignore: import_of_legacy_library_into_null_safe
import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final String cityName;
  final double temperature;

  Weather({
    required this.cityName,
    required this.temperature,
  }) : super([cityName, temperature]);
}
