import 'dart:async';
import 'dart:convert';

import 'package:exercicio_07/post.dart';
import 'package:exercicio_07/post_details.dart';
import 'package:exercicio_07/post_details_page_props.dart';
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
      title: 'Fetch Post',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == PostDetails.route) {
          final args = settings.arguments as PostDetailsPageProps;

          return MaterialPageRoute(
            builder: (context) {
              return PostDetails(
                postId: args.postId,
              );
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
  final ScrollController _scrollController = ScrollController();
  int page = 1;
  bool loading = false;
  List<dynamic> _posts = [];

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

  Future<List<dynamic>> fetchPosts(int page) async {
    loading = true;
    final response = await http.get(Uri.parse(
        'https://jsonplaceholder.typicode.com/posts?_page=$page&_limit=12'));

    print("fetching...");

    if (response.statusCode != 200) {
      throw Exception('Failed to load Post');
    }

    List<dynamic> posts =
        jsonDecode(response.body).map((e) => Post.fromJson(e)).toList();

    _posts.addAll(posts);

    loading = false;
    return _posts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Leia um Post"),
      ),
      body: Center(
          child: FutureBuilder<List<dynamic>>(
        future: fetchPosts(page),
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
                    subtitle: Text(snapshot.data![index].id.toString()),
                    onTap: () {
                      if (snapshot.hasData) {
                        Navigator.pushNamed(context, PostDetails.route,
                            arguments:
                                PostDetailsPageProps(snapshot.data![index].id));
                      }
                    },
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
