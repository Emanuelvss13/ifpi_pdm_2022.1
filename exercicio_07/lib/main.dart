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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Album"),
      ),
      body: Center(
          child: FutureBuilder<List>(
        future: fetchAlbuns(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                      child: ListTile(
                    title: Text(snapshot.data![index].title),
                    onTap: () {
                      if (snapshot.hasData) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('álbum ' +
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

Future<dynamic> fetchAlbum() async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

  if (response.statusCode != 200) {
    throw Exception('Failed to load album');
  }

  return Album.fromJson(jsonDecode(response.body));
}

Future<List> fetchAlbuns() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));

  if (response.statusCode != 200) {
    throw Exception('Failed to load album');
  }

  return jsonDecode(response.body).map((e) => Album.fromJson(e)).toList();
}
