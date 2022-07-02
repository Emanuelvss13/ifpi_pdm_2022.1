import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:bloc_library/bloc/weather_event.dart';
import 'package:bloc_library/bloc/weather_state.dart';
import 'package:bloc_library/model/weather.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    // ignore: void_checks
    on<GetWeather>((event, emit) async {
      emit(WeatherLoading());
      final weather = await _fetchWeatherFromFakeApi(event.cityName);
      emit(WeatherLoaded(weather));
    });
  }

  WeatherState get initialState => WeatherInitial();

  // Stream<WeatherState> mapEventToState(
  //   WeatherEvent event,
  // ) async* {
  //   if (event is GetWeather) {
  //     yield WeatherLoading();
  //     final weather = await _fetchWeatherFromFakeApi(event.cityName);
  //     yield WeatherLoaded(weather);
  //   }
  // }

  Future<Weather> _fetchWeatherFromFakeApi(String cityName) {
    // Simulate network delay
    return Future.delayed(
      const Duration(seconds: 1),
      () {
        return Weather(
          cityName: cityName,
          // Temperature between 20 and 35.99
          temperature: 20 + Random().nextInt(15) + Random().nextDouble(),
        );
      },
    );
  }
}
