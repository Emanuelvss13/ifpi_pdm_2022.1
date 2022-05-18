import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:q_07/cripto.dart';

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
      home: const MyHomePage(),
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
  String order = 'desc';
  String sort = 'rank';

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(seconds: 1), curve: Curves.ease);
  }

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

  Future<List<dynamic>> fetchCriptos(
      int page, String order, String sort) async {
    loading = true;
    var response;

    if (_criptos.isEmpty) {
      response = await http.get(Uri.parse(
          'https://api.coinbase.com/v2/assets/search?base=USD&limit=12&order=$order&sort=$sort'));
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
          SizedBox(
            width: 300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DropdownButton<String>(
                  value: order,
                  icon: const Icon(Icons.arrow_downward, color: Colors.black87),
                  elevation: 16,
                  alignment: Alignment.center,
                  style: const TextStyle(color: Colors.black87),
                  underline: Container(
                    height: 2,
                    color: Colors.black87,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      _scrollToTop();
                      _criptos = [];
                      order = newValue!;
                    });
                  },
                  items: <String>['asc', 'desc']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                DropdownButton<String>(
                  value: sort,
                  icon: const Icon(Icons.arrow_downward, color: Colors.black87),
                  elevation: 16,
                  alignment: Alignment.center,
                  style: const TextStyle(color: Colors.black87),
                  underline: Container(
                    height: 2,
                    color: Colors.black87,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      _scrollToTop();
                      _criptos = [];
                      sort = newValue!;
                    });
                  },
                  items: <String>['name', 'rank']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Center(
                child: FutureBuilder<List<dynamic>>(
              future: fetchCriptos(page, order, sort),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      shrinkWrap: true,
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
                            child:
                                Image.network(snapshot.data![index].imageUrl),
                          ),
                          title: Text(snapshot.data![index].name,
                              style: const TextStyle(color: Colors.white)),
                          subtitle: Text(snapshot.data![index].symbol,
                              style: const TextStyle(color: Colors.white)),
                        ));
                      });
                } else if (snapshot.hasError) {
                  return Text('$snapshot');
                }

                return const Center(child: CircularProgressIndicator());
              },
            )),
            (() {
              if (loading && _criptos.isNotEmpty) {
                return Column(
                  children: const [
                    Center(child: CircularProgressIndicator()),
                    SizedBox(
                      height: 10,
                    )
                  ],
                );
              } else {
                return Text("Fim");
              }
            }())
          ],
        ),
      ),
    );
  }
}
