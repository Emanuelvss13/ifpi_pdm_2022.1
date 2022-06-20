import 'dart:convert';
import 'dart:math';

import 'package:exercicio_11/core/errors/exception.dart';
import 'package:exercicio_11/data/datasource/rick_and_morty_local_datasource.dart';
import 'package:exercicio_11/domain/entities/character.dart';
import 'package:exercicio_11/data/models/character_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RickAndMortylocalDataSourceImpl extends RickAndMortyLocalDatasource {
  final SharedPreferences sharedPreferences;

  RickAndMortylocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheCharacter(CharacterModel characterToCache) {
    return sharedPreferences.setString(
      characterToCache.id.toString(),
      json.encode(characterToCache.toJson()),
    );
  }

  @override
  Future<Character> getRandomCharacter() {
    final randomId = Random().nextInt(827);
    final jsonString = sharedPreferences.getString(randomId.toString());

    if (jsonString != null) {
      return Future.value(CharacterModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }
}
