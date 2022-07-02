// ignore: import_of_legacy_library_into_null_safe
import 'package:equatable/equatable.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

@immutable
abstract class WeatherEvent extends Equatable {
  WeatherEvent([List props = const []]) : super(props);
}

class GetWeather extends WeatherEvent {
  final String cityName;

  GetWeather(this.cityName) : super([cityName]);
}
