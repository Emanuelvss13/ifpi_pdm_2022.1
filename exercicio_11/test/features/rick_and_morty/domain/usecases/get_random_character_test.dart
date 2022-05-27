import 'package:dartz/dartz.dart';
import 'package:exercicio_11/domain/entities/character.dart';
import 'package:exercicio_11/domain/repositories/ricky_and_morty_repository.dart';
import 'package:exercicio_11/domain/use-cases/get_random_character.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_random_character_test.mocks.dart';

@GenerateMocks([RickAndMortyRepository])
void main() {
  late GetRandomCharacter usecase;
  late MockRickAndMortyRepository mockRickAndMortyRepository;

  const tCharacter = Character(
      id: 1,
      name: "rick",
      status: "alive",
      species: "human",
      type: "",
      gender: "male",
      image: "");

  setUp(() {
    mockRickAndMortyRepository = MockRickAndMortyRepository();
    usecase = GetRandomCharacter(mockRickAndMortyRepository);
  });

  test(
    'should return a random character',
    () async {
      // arrange
      when(mockRickAndMortyRepository.getRandomCharacter())
          .thenAnswer((_) async => const Right(tCharacter));

      final result = await usecase.execute();

      // assert
      expect(result, const Right(tCharacter));
      verify(mockRickAndMortyRepository.getRandomCharacter());
      verifyNoMoreInteractions(mockRickAndMortyRepository);
    },
  );
}
