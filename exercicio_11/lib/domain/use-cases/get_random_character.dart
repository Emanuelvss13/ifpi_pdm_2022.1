import 'package:dartz/dartz.dart';
import 'package:exercicio_11/core/errors/failure.dart';
import 'package:exercicio_11/domain/entities/character.dart';
import 'package:exercicio_11/domain/repositories/ricky_and_morty_repository.dart';

class GetRandomCharacter {
  final RickAndMortyRepository repository;

  GetRandomCharacter(this.repository);

  Future<Either<Failure, Character>> execute() async {
    return await repository.getRandomCharacter();
  }
}
