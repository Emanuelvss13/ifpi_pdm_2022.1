import 'dart:async';
import 'dart:convert';

import 'package:exercicio_07/comment.dart';
import 'package:exercicio_07/post.dart';
import 'package:exercicio_07/post_with_user.dart';
import 'package:exercicio_07/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostDetails extends StatefulWidget {
  static const route = '/post-detail';

  final int postId;

  const PostDetails({Key? key, required this.postId}) : super(key: key);

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  Future<PostWithUser> fetchPostById() async {
    var response = await http.get(Uri.parse(
        'https://jsonplaceholder.typicode.com/posts/${widget.postId}'));

    if (response.statusCode != 200) {
      throw Exception('Failed to load Post');
    }

    Post post = Post.fromJson(jsonDecode(response.body));

    var responseUser = await http.get(Uri.parse(
        'https://jsonplaceholder.typicode.com/users/${post.userId.toString()}'));

    User user = User.fromJson(jsonDecode(responseUser.body));

    return PostWithUser(
      post: post,
      user: user,
    );
  }

  Future<List> fetchCommentsFromPost(int postId) async {
    var responseComments = await http.get(Uri.parse(
        'https://jsonplaceholder.typicode.com/comments?postId=$postId'));

    if (responseComments.statusCode != 200) {
      throw Exception('Failed to load Post');
    }

    List<dynamic> comments = jsonDecode(responseComments.body)
        .map((e) => Comment.fromJson(e))
        .toList();

    return comments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalhes do Post"),
      ),
      body: Center(
          child: FutureBuilder<PostWithUser>(
        future: fetchPostById(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Card(
                child: Column(
                  children: [
                    Text(snapshot.data!.post.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 26)),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.black12),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(snapshot.data!.post.body,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 18)),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("Por: " + snapshot.data!.user.name,
                        textAlign: TextAlign.left,
                        style: const TextStyle(fontSize: 18)),
                    Text("Contato: " + snapshot.data!.user.email,
                        textAlign: TextAlign.left,
                        style: const TextStyle(fontSize: 18)),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.black12),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("Comentários"),
                    Column(
                      children: [
                        SizedBox(
                          height: 300,
                          child: FutureBuilder<List<dynamic>>(
                            future:
                                fetchCommentsFromPost(snapshot.data!.post.id),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                    padding: const EdgeInsets.all(8),
                                    itemCount: snapshot.data!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Column(
                                        children: [
                                          Card(
                                              child: ListTile(
                                            title: Text(
                                                snapshot.data![index].name),
                                            subtitle: Text(
                                                snapshot.data![index].body),
                                          )),
                                        ],
                                      );
                                    });
                              } else if (snapshot.hasError) {
                                return Text('$snapshot');
                              }

                              return const Center(
                                  child: CircularProgressIndicator());
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Text('$snapshot');
          }

          return const Center(child: CircularProgressIndicator());
        },
      )),
    );
  }
}
