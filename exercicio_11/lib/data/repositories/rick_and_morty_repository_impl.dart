import 'package:exercicio_11/core/platform/network_info.dart';
import 'package:exercicio_11/data/datasource/rick_and_morty_local_datasource.dart';
import 'package:exercicio_11/data/datasource/rick_and_morty_remote_datasource.dart';
import 'package:exercicio_11/domain/entities/character.dart';
import 'package:exercicio_11/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:exercicio_11/domain/repositories/ricky_and_morty_repository.dart';

class RickAndMortyRepositoryImpl implements RickAndMortyRepository {
  
  NetworkInfo networkInfo;
  RickAndMortyLocalDatasource rickAndMortyLocalDatasource;
  RickAndMortyRemoteDatasource rickAndMortyRemoteDatasource;

  RickAndMortyRepositoryImpl({
    required this.networkInfo,
    required this.rickAndMortyLocalDatasource,
    required this.rickAndMortyRemoteDatasource
  })
  
  @override
  Future<Either<Failure, Character>> getCharacterByName(String name) {
    return null;
  }

  @override
  Future<Either<Failure, Character>> getRandomCharacter() {
    return null;
  }
}
