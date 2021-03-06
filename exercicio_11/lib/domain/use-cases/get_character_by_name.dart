import 'package:dartz/dartz.dart';
import 'package:exercicio_11/core/errors/failure.dart';
import 'package:exercicio_11/core/usecases/usecase.dart';
import 'package:exercicio_11/domain/entities/character.dart';
import 'package:exercicio_11/domain/repositories/ricky_and_morty_repository.dart';

class GetCharacterByName extends UseCase<Character, Params> {
  final RickAndMortyRepository repository;

  GetCharacterByName(this.repository);

  @override
  Future<Either<Failure, Character>> call(Params params) async {
    return await repository.getCharacterByName(params.name);
  }
}
