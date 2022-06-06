import 'package:dartz/dartz.dart';
import 'package:exercicio_11/core/usecases/usecase.dart';
import 'package:exercicio_11/domain/entities/character.dart';
import 'package:exercicio_11/domain/repositories/ricky_and_morty_repository.dart';
import 'package:exercicio_11/domain/use-cases/get_character_by_name.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_character_by_name_test.mocks.dart';

@GenerateMocks([RickAndMortyRepository])
void main() {
  late GetCharacterByName usecase;
  late MockRickAndMortyRepository mockRickAndMortyRepository;
  String characterNameToSearch = 'rick';

  const tCharacters = [
    Character(
        id: 1,
        name: "rick",
        status: "alive",
        species: "human",
        type: "",
        gender: "male",
        image: ""),
    Character(
        id: 2,
        name: "morty",
        status: "alive",
        species: "human",
        type: "",
        gender: "male",
        image: ""),
  ];

  setUp(() {
    mockRickAndMortyRepository = MockRickAndMortyRepository();
    usecase = GetCharacterByName(mockRickAndMortyRepository);
  });

  test(
    'should return a character by name',
    () async {
      // arrange
      when(mockRickAndMortyRepository.getCharacterByName(characterNameToSearch))
          .thenAnswer((_) async => Right(tCharacters[0]));

      final result = await usecase(Params(name: characterNameToSearch));

      // assert
      expect(result, Right(tCharacters[0]));
      // expect(result, matcher)
      verify(
          mockRickAndMortyRepository.getCharacterByName(characterNameToSearch));
      verifyNoMoreInteractions(mockRickAndMortyRepository);
    },
  );
}
