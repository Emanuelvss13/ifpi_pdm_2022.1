import 'dart:async';
import 'package:exercicio_07/favorited_cripto.dart';
import 'package:exercicio_07/cripto_details.dart';
import 'package:exercicio_07/cripto_details_page_props.dart';
import 'package:exercicio_07/db.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

final oCcy = NumberFormat("#,##0.00", "en_US");

class Favorites extends StatefulWidget {
  static const route = '/favorites';
  const Favorites({Key? key}) : super(key: key);

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  int refetch = 0;
  Future<List<dynamic>> fetchFavoritedCriptos() async {
    var db = await DB.instance.database;

    List rawList = await db.rawQuery('SELECT * FROM favorites');

    return rawList;
  }

  Future<void> deleteFavoritedCripto(String id) async {
    var db = await DB.instance.database;

    try {
      await db.delete('favorites', where: "id=?", whereArgs: [id]);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: const Text(
          "Favorites",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
          child: FutureBuilder<List<dynamic>>(
        future: fetchFavoritedCriptos(),
        builder: (context, snapshot) {
          if (snapshot.data!.isEmpty) {
            return Center(
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("As suas moedas favoritas aparecerão aqui!",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 24)),
                    Icon(
                      Icons.star,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            );
          }
          if (snapshot.hasData) {
            return ListView.builder(
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
                      child: Image.network(snapshot.data![index]['image_url']),
                    ),
                    title: Text(snapshot.data![index]['name'],
                        style: const TextStyle(color: Colors.white)),
                    subtitle: Text(snapshot.data![index]['symbol'],
                        style: const TextStyle(color: Colors.white)),
                    trailing: GestureDetector(
                      onTap: () {
                        deleteFavoritedCripto(snapshot.data![index]['id']);
                        setState(() {
                          refetch++;
                        });
                      },
                      child: const Icon(
                        Icons.restore_from_trash,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      if (snapshot.hasData) {
                        Navigator.pushNamed(context, CriptoDetails.route,
                            arguments: CriptoDetailsPageProps(
                                snapshot.data![index]['id']));
                      }
                    },
                  ));
                });
          } else if (snapshot.hasError) {
            return Text(
              '$snapshot',
              style: const TextStyle(color: Colors.white),
            );
          }

          return Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const SizedBox(
                height: 100,
              ),
              const Center(child: CircularProgressIndicator()),
            ],
          );
        },
      )),
    );
  }
}
