import 'package:dartz/dartz.dart';
import 'package:exercicio_11/core/errors/failure.dart';
import 'package:exercicio_11/domain/entities/character.dart';
import 'package:exercicio_11/domain/repositories/ricky_and_morty_repository.dart';

class GetCharacterByName {
  final RickAndMortyRepository repository;

  GetCharacterByName(this.repository);

  Future<Either<Failure, Character>> execute({required String name}) async {
    return await repository.getCharacterByName(name);
  }
}
