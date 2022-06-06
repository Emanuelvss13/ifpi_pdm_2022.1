import 'dart:convert';

import 'package:exercicio_11/data/models/character_model.dart';
import 'package:exercicio_11/domain/entities/character.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  const characterModel = CharacterModel(
      id: 1,
      name: 'Rick Sanchez',
      gender: 'Male',
      species: 'Human',
      status: 'Alive',
      type: '',
      image: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg');

  test(
    'should be a subclass of Character entity',
    () async {
      expect(characterModel, isA<Character>());
    },
  );

  test(
    'should return a valid model from JSON',
    () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('character.json'));
      // act
      final result = CharacterModel.fromJson(jsonMap);
      // assert
      expect(result, characterModel);
    },
  );
}
