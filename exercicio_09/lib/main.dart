import 'dart:async';
import 'dart:convert';

import 'package:exercicio_07/cripto.dart';
import 'package:exercicio_07/db.dart';
import 'package:exercicio_07/favorites.dart';
import 'package:exercicio_07/cripto_details.dart';
import 'package:exercicio_07/cripto_details_page_props.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CriptoInfo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == CriptoDetails.route) {
          final args = settings.arguments as CriptoDetailsPageProps;

          return MaterialPageRoute(
            builder: (context) {
              return CriptoDetails(
                criptoId: args.id,
              );
            },
          );
        }
        if (settings.name == Favorites.route) {
          return MaterialPageRoute(
            builder: (context) {
              return const Favorites();
            },
          );
        }
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool loading = true;
  int page = 1;
  final ScrollController _scrollController = ScrollController();
  String _nextPage = '';
  List<dynamic> _criptos = [];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !loading) {
        setState(() {
          page++;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<List<dynamic>> fetchCriptos(int page) async {
    loading = true;
    var response;

    if (_criptos.isEmpty) {
      response = await http.get(Uri.parse(
          'https://api.coinbase.com/v2/assets/search?base=USD&limit=12'));
    } else {
      response =
          await http.get(Uri.parse("https://api.coinbase.com" + _nextPage));
    }

    if (response.statusCode != 200) {
      throw Exception('Failed to load criptos');
    }

    final json = jsonDecode(response.body);
    _nextPage = json['pagination']['next_uri'];

    List<dynamic> criptos =
        json['data'].map((e) => Cripto.fromJson(e)).toList();

    criptos.removeLast();

    _criptos.addAll(criptos);

    loading = false;
    return _criptos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: const Text(
          "CriptoInfo",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Favorites.route);
            },
            child: const Icon(
              Icons.star,
              size: 40,
            ),
          )
        ],
      ),
      body: Center(
          child: FutureBuilder<List<dynamic>>(
        future: fetchCriptos(page),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(8),
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                      child: ListTile(
                    tileColor: const Color.fromRGBO(25, 25, 25, 1),
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.network(snapshot.data![index].imageUrl),
                    ),
                    title: Text(snapshot.data![index].name,
                        style: const TextStyle(color: Colors.white)),
                    subtitle: Text(snapshot.data![index].symbol,
                        style: const TextStyle(color: Colors.white)),
                    onTap: () async {
                      if (snapshot.hasData) {
                        Navigator.pushNamed(context, CriptoDetails.route,
                            arguments: CriptoDetailsPageProps(
                                snapshot.data![index].id));
                      }
                    },
                    onLongPress: () async {
                      addCriptoToFavorite(snapshot.data![index], context);
                    },
                    trailing: criptoChangeText(
                        snapshot.data![index].latestPrice.percentChange.day),
                  ));
                });
          } else if (snapshot.hasError) {
            return Text('$snapshot');
          }

          return const Center(child: CircularProgressIndicator());
        },
      )),
    );
  }
}

Text criptoChangeText(double value) {
  if (value > 0) {
    // ignore: avoid_unnecessary_containers
    return Text(
      "+" + (value * 100).toStringAsPrecision(3) + "%",
      style: const TextStyle(color: Colors.green),
    );
  }

  return Text(
    (value * 100).toStringAsPrecision(5) + "%",
    style: const TextStyle(color: Colors.red),
  );
}

void addCriptoToFavorite(snapshot, context) async {
  var db = await DB.instance.database;

  List cripto =
      await db.rawQuery("SELECT * FROM favorites where id=?", [snapshot.id]);

  if (cripto.isNotEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Essa moeda ja foi adicionada às favoritas!"),
      duration: Duration(milliseconds: 750),
    ));
    return;
  }

  try {
    db.insert('favorites', {
      'id': snapshot.id,
      'name': snapshot.name,
      'symbol': snapshot.symbol,
      'image_url': snapshot.imageUrl
    });
  } catch (e) {
    print(e);
  }

  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    content: Text("Moeda adicionada às favoritas"),
    duration: Duration(milliseconds: 750),
  ));
}
