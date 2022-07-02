import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bloc.dart';
import 'model/weather.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WeatherPage(),
    );
  }
}

// Since version 0.17.0, you can use a stateless widget with Bloc
class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fake Weather App"),
      ),
      body: BlocProvider(
        create: (context) => WeatherBloc(),
        child: const WeatherPageChild(),
      ),
    );
  }
}

class WeatherPageChild extends StatelessWidget {
  const WeatherPageChild({
    key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      alignment: Alignment.center,
      child: BlocListener(
        bloc: BlocProvider.of<WeatherBloc>(context),
        listener: (BuildContext context, WeatherState state) {
          if (state is WeatherLoaded) {
            print("Loaded: ${state.weather.cityName}");
          }
        },
        child: BlocBuilder(
          bloc: BlocProvider.of<WeatherBloc>(context),
          builder: (BuildContext context, WeatherState state) {
            // Changing the UI based on the current state
            if (state is WeatherInitial) {
              return buildInitialInput();
            } else if (state is WeatherLoading) {
              return buildLoading();
            } else if (state is WeatherLoaded) {
              return buildColumnWithData(state.weather);
            } else {
              return error();
            }
          },
        ),
      ),
    );
  }

  Widget buildInitialInput() {
    return const Center(
      child: CityInputField(),
    );
  }

  Widget error() {
    return const Center(
      child: Text("Ocorreu um erro"),
    );
  }

  Widget buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  // Builds widgets from the starter UI with custom weather data
  Column buildColumnWithData(Weather weather) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          weather.cityName,
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          // Display the temperature with 1 decimal place
          "${weather.temperature.toStringAsFixed(1)} °C",
          style: const TextStyle(fontSize: 80),
        ),
        const CityInputField(),
      ],
    );
  }
}

class CityInputField extends StatefulWidget {
  const CityInputField({
    key,
  }) : super(key: key);

  @override
  _CityInputFieldState createState() => _CityInputFieldState();
}

class _CityInputFieldState extends State<CityInputField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        onSubmitted: (value) => submitCityName(value, context),
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: "Enter a city",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          suffixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }

  void submitCityName(String cityName, BuildContext context) {
    // Get the Bloc using the BlocProvider
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);
    // Initiate getting the weather
    weatherBloc.add(GetWeather(cityName));
  }
}
