import 'package:dartz/dartz.dart';
import 'package:exercicio_11/core/errors/exception.dart';
import 'package:exercicio_11/core/errors/failure.dart';
import 'package:exercicio_11/core/platform/network_info.dart';
import 'package:exercicio_11/data/datasource/rick_and_morty_local_datasource.dart';
import 'package:exercicio_11/data/datasource/rick_and_morty_remote_datasource.dart';
import 'package:exercicio_11/data/models/character_model.dart';
import 'package:exercicio_11/data/repositories/rick_and_morty_repository_impl.dart';
import 'package:exercicio_11/domain/entities/character.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'rick_and_morty_repository_impl_test.mocks.dart';

@GenerateMocks(
    [RickAndMortyRemoteDatasource, RickAndMortyLocalDatasource, NetworkInfo])
void main() {
  MockRickAndMortyRemoteDatasource mockRemoteDataSource =
      MockRickAndMortyRemoteDatasource();
  MockRickAndMortyLocalDatasource mockLocalDataSource =
      MockRickAndMortyLocalDatasource();
  NetworkInfo mockNetworkInfo = MockNetworkInfo();

  RickAndMortyRepositoryImpl repository = RickAndMortyRepositoryImpl(
    rickAndMortyRemoteDatasource: mockRemoteDataSource,
    rickAndMortyLocalDatasource: mockLocalDataSource,
    networkInfo: mockNetworkInfo,
  );

  const tName = "Rick";

  const tCharacterModel = CharacterModel(
    id: 1,
    name: "rick",
    gender: "Male",
    image: 'image',
    species: 'Human',
    status: 'Alive',
    type: "",
  );

  const Character tCharacter = tCharacterModel;

  group('getCharacterByName', () {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      test('should check if the device is online', () {
        verifyNever(
          mockNetworkInfo.isConnected,
        );
      });
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getCharacterByName(tName))
              .thenAnswer((_) async => tCharacterModel);
          // act
          final result = await repository.getCharacterByName(tName);
          // assert
          verify(mockRemoteDataSource.getCharacterByName(tName));
          expect(result, equals(const Right(tCharacter)));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockRemoteDataSource.getCharacterByName(tName))
              .thenThrow(ServerException());
          // act
          final result = await repository.getCharacterByName(tName);
          // assert
          verify(mockRemoteDataSource.getCharacterByName(tName));
          // verifyZeroInteractions(mockLocalDataSource);
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });
  });
}
