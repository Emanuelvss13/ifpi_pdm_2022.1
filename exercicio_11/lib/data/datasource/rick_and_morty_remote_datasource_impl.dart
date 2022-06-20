import 'dart:convert';
import 'dart:math';

import 'package:exercicio_11/core/errors/exception.dart';
import 'package:http/http.dart' as http;
import 'package:exercicio_11/data/datasource/rick_and_morty_remote_datasource.dart';
import 'package:exercicio_11/data/models/character_model.dart';

class RickAndMortyRemoteDatasourceImpl extends RickAndMortyRemoteDatasource {
  final http.Client client;

  RickAndMortyRemoteDatasourceImpl({required this.client});

  @override
  Future<CharacterModel> getCharacterByName(String name) async {
    final response = await client.get(
        Uri.parse('https://rickandmortyapi.com/api/character/?name=$name'));

    if (response.statusCode == 200) {
      return CharacterModel.fromJsonByName(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<CharacterModel> getRandomCharacter() async {
    final randomId = Random().nextInt(827);

    final response = await client
        .get(Uri.parse('https://rickandmortyapi.com/api/character/$randomId'));

    if (response.statusCode == 200) {
      return CharacterModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
