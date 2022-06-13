import 'package:exercicio_11/data/models/character_model.dart';
import 'package:exercicio_11/domain/entities/character.dart';

abstract class RickAndMortyLocalDatasource {
  Future<Character> getCharacterByName(String name);
  Future<Character> getRandomCharacter();
  Future<void> cacheCharacter(CharacterModel characterToCache);
}
