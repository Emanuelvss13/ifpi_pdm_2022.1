import 'dart:async';
import 'dart:convert';
import 'package:exercicio_07/cripto.dart';
import 'package:exercicio_07/favorites.dart';
import 'package:exercicio_07/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';

final oCcy = NumberFormat("#,##0.00", "en_US");

class CriptoDetails extends StatefulWidget {
  static const route = '/post-detail';

  final String criptoId;

  const CriptoDetails({Key? key, required this.criptoId}) : super(key: key);

  @override
  State<CriptoDetails> createState() => _CriptoDetailsState();
}

class _CriptoDetailsState extends State<CriptoDetails> {
  Future<Cripto> fetchCriptoById() async {
    var response = await http.get(Uri.parse(
        'https://api.coinbase.com/v2/assets/search?base=USD&limit=1&starting_after=${widget.criptoId}'));

    if (response.statusCode != 200) {
      throw Exception('Failed to load cripto');
    }

    Cripto cripto = Cripto.fromJson(jsonDecode(response.body)['data'][0]);
    print(jsonDecode(response.body)['data'][0]);
    return cripto;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: const Text(
          "Deeply",
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
      body: SingleChildScrollView(
        child: Center(
            child: FutureBuilder<Cripto>(
          future: fetchCriptoById(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Center(
                child: Column(
                  children: [
                    Container(
                      width: 1000,
                      height: 250,
                      color: Color(int.parse(
                              snapshot.data!.color.substring(1, 7),
                              radix: 16) +
                          0xFF000000),
                      child: Image.network(snapshot.data!.imageUrl),
                    ),
                    Container(
                      color: const Color.fromRGBO(25, 25, 25, 1),
                      child: Column(children: [
                        Container(
                          height: 5,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(snapshot.data!.name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 26, color: Colors.white)),
                        Text(
                            "Market cap: ${oCcy.format(double.parse(snapshot.data!.marketCap))} ${snapshot.data!.latestPrice.amount.currency}",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 18, color: Colors.white)),
                        Text("rank: #" + snapshot.data!.rank.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 18, color: Colors.white)),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text("Market details",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: 26, color: Colors.white)),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                            "Amount: ${oCcy.format(double.parse(snapshot.data!.latestPrice.amount.amount))} ${snapshot.data!.latestPrice.amount.currency}",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 18, color: Colors.white)),
                        Text(
                            "hour: " +
                                (snapshot.data!.latestPrice.percentChange.hour *
                                        100)
                                    .toStringAsPrecision(5) +
                                "%",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 18,
                                height: 1.25,
                                color: Colors.white)),
                        Text(
                            "day: " +
                                (snapshot.data!.latestPrice.percentChange.day *
                                        100)
                                    .toStringAsPrecision(5) +
                                "%",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 18,
                                height: 1.25,
                                color: Colors.white)),
                        Text(
                            "week: " +
                                (snapshot.data!.latestPrice.percentChange.week *
                                        100)
                                    .toStringAsPrecision(5) +
                                "%",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 18,
                                height: 1.25,
                                color: Colors.white)),
                        Text(
                            "month: " +
                                (snapshot.data!.latestPrice.percentChange
                                            .month *
                                        100)
                                    .toStringAsPrecision(5) +
                                "%",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 18,
                                height: 1.25,
                                color: Colors.white)),
                        Text(
                            "year: " +
                                (snapshot.data!.latestPrice.percentChange.year *
                                        100)
                                    .toStringAsPrecision(5) +
                                "%",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 18,
                                height: 1.25,
                                color: Colors.white)),
                        Text(
                            "all: " +
                                (snapshot.data!.latestPrice.percentChange.all *
                                        100)
                                    .toStringAsPrecision(5) +
                                "%",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 18,
                                height: 1.25,
                                color: Colors.white)),
                        Text(
                            "volume 24h: ${oCcy.format(double.parse(snapshot.data!.volume24h))} ${snapshot.data!.latestPrice.amount.currency}",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 18,
                                height: 1.25,
                                color: Colors.white)),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(snapshot.data!.description ?? '',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 18,
                                height: 1.25,
                                color: Colors.white)),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: const BorderSide(
                                          color: Colors.deepOrange)))),
                          child: const Text(
                            'Favorite',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            addCriptoToFavorite(snapshot.data!, context);
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ]),
                    )
                  ],
                ),
              );
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
      ),
    );
  }
}
