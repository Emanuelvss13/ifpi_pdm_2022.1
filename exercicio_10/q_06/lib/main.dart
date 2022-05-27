import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Pesquisa',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const List<String> _pokemons = <String>[
    'bulbasaur',
    'ivysaur',
    'venusaur',
    'charmander',
    'charmeleon',
    'charizard',
    'squirtle',
    'wartortle',
    'blastoise',
    'pikachu',
  ];

  List<String> _foundPokemons = [];
  @override
  initState() {
    _foundPokemons = _pokemons;
    super.initState();
  }

  void _filter(String enteredKeyword) {
    List<String> results = [];
    if (enteredKeyword.isEmpty) {
      results = _pokemons;
    } else {
      results = _pokemons
          .where((pokemon) =>
              pokemon.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundPokemons = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesquisa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
              _filter(textEditingValue.text);
              if (textEditingValue.text == '') {
                return const Iterable<String>.empty();
              }

              return _pokemons.where((option) {
                return option.contains(textEditingValue.text.toLowerCase());
              });
            }),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: _foundPokemons.isNotEmpty
                  ? ListView.builder(
                      itemCount: _foundPokemons.length,
                      itemBuilder: (context, index) => Card(
                        color: Colors.amberAccent,
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          title: Text(_foundPokemons[index]),
                        ),
                      ),
                    )
                  : const Text(
                      'Não encontrado',
                      style: TextStyle(fontSize: 24),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
