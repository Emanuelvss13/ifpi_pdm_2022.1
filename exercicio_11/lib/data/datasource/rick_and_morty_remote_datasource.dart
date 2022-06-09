import 'package:exercicio_11/data/models/character_model.dart';

abstract class RickAndMortyRemoteDatasource {
  Future<CharacterModel> getCharacterByName(String name);
  Future<CharacterModel> getRandomCharacter();
}
