import 'package:exercicio_11/domain/entities/character.dart';

abstract class RickAndMortyRemoteDatasource {
  Future<Character> getCharacterByName(String name);
  Future<Character> getRandomCharacter();
}
