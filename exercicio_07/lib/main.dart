import 'dart:convert';

import 'package:exercicio_07/Album.dart';
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
      title: 'Fetch Album',
      theme: ThemeData(
        primarySwatch: Colors.red,
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
  final ScrollController _scrollController = ScrollController();
  int page = 1;
  bool loading = false;
  late Future<List<Album>> _albuns;
  bool fuloaded = false;

  @override
  void initState() {
    super.initState();
    _albuns = fetchAlbunsInfinite(page);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !loading) {
        setState(() {
          page++;
        });
        _albuns = fetchAlbunsInfinite(page);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<List<Album>> fetchAlbunsInfinite(int page) async {
    loading = true;

    List<Album> albuns = page == 1 ? [] : await _albuns;
    final response = await http.get(Uri.parse(
        'https://jsonplaceholder.typicode.com/photos?_page=1&_limit=5'));

    if (response.statusCode != 200) {
      throw Exception('Failed to load album');
    }

    print(Album.fromJson(jsonDecode(response.body)[0]));

    jsonDecode(response.body).map((e) => print(Album.fromJson(e)));

    loading = false;
    return albuns;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Album"),
      ),
      body: Center(
          child: FutureBuilder<List<Album>>(
        future: _albuns,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(8),
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                      child: ListTile(
                    title: Text(snapshot.data![index].title),
                    onTap: () {
                      if (snapshot.hasData) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('??lbum ' +
                              snapshot.data![index].title +
                              ' clicado'),
                          duration: const Duration(milliseconds: 750),
                        ));
                      }
                    },
                  ));
                });
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          return const Center(child: CircularProgressIndicator());
        },
      )),
    );
  }
}

// Future<dynamic> fetchAlbum(int AlbumId) async {
//   final response = await http
//       .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

//   if (response.statusCode != 200) {
//     throw Exception('Failed to load album');
//   }

//   return Album.fromJson(jsonDecode(response.body));
// }

// Future<List<dynamic>> fetchAlbuns() async {
//   final response =
//       await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));

//   if (response.statusCode != 200) {
//     throw Exception('Failed to load album');
//   }

//   return jsonDecode(response.body).map((e) => Album.fromJson(e)).toList();
// }


