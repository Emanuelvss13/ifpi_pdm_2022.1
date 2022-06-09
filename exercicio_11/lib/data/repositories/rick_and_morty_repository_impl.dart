import 'package:exercicio_11/core/errors/exception.dart';
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

  RickAndMortyRepositoryImpl(
      {required this.networkInfo,
      required this.rickAndMortyLocalDatasource,
      required this.rickAndMortyRemoteDatasource});

  @override
  Future<Either<Failure, Character>> getCharacterByName(String name) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCharacter =
            await rickAndMortyRemoteDatasource.getCharacterByName(name);
        rickAndMortyLocalDatasource.cacheCharacter(remoteCharacter);
        return Right(remoteCharacter);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localCharacter =
            await rickAndMortyLocalDatasource.getLastCharacter();
        return Right(localCharacter);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Character>> getRandomCharacter() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCharacter =
            await rickAndMortyRemoteDatasource.getRandomCharacter();
        rickAndMortyLocalDatasource.cacheCharacter(remoteCharacter);
        return Right(remoteCharacter);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localCharacter =
            await rickAndMortyLocalDatasource.getLastCharacter();
        return Right(localCharacter);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
