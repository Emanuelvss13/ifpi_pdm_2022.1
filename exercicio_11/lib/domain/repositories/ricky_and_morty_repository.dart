import 'package:dartz/dartz.dart';
import 'package:exercicio_11/domain/entities/character.dart';

import '../../core/errors/failure.dart';

abstract class RickAndMortyRepository {
  Future<Either<Failure, Character>> getRandomCharacter();
  Future<Either<Failure, Character>> getCharacterByName(String name);
}
