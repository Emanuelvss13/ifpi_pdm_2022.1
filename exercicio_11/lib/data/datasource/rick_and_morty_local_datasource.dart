import 'package:exercicio_11/domain/entities/character.dart';

abstract class RickAndMortyLocalDatasource {
  Future<Character> getCharacterByName(String name);
  Future<Character> getRandomCharacter();
}
