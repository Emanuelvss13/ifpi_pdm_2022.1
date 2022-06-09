import 'package:exercicio_11/data/models/character_model.dart';
import 'package:exercicio_11/domain/entities/character.dart';

abstract class RickAndMortyLocalDatasource {
  Future<Character> getLastCharacter();
  Future<void> cacheCharacter(CharacterModel characterToCache);
}
