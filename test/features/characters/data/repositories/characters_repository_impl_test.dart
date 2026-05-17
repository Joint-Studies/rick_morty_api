import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_morty_api/features/characters/data/datasources/characters_remote_datasource.dart';
import 'package:rick_morty_api/features/characters/data/repositories/characters_repository_impl.dart';
import 'package:rick_morty_api/features/characters/data/models/response_model.dart';
import 'package:rick_morty_api/features/characters/domain/entities/response_entity.dart';

import '../../../../mock/character_mock.dart';

class MockCharactersRemoteDatasource extends Mock implements CharactersRemoteDatasource {}

void main() {
  late CharactersRepositoryImpl repository;
  late MockCharactersRemoteDatasource mockRemoteDatasource;

  setUp(() {
    mockRemoteDatasource = MockCharactersRemoteDatasource();
    repository = CharactersRepositoryImpl(remoteDatasource: mockRemoteDatasource);
  });

  final mockResponseModel = ResponseModel.fromJson(characterResponseFromJson);

  group('LocationRepositoryImpl', () {
    test('getCharactersResponse should return ResponseEntity', () async {
      when(() => mockRemoteDatasource.getCharactersResponse()).thenAnswer((_) async => mockResponseModel);

      final result = await repository.getCharacterResponse();

      expect(result, isA<ResponseEntity>());
      expect(result.infoEntity?.count, 826);
      expect(result.characterEntity?.name, '');
      expect(result.charactersEntity?.first.name, 'Toxic Rick');

      verify(() => mockRemoteDatasource.getCharactersResponse()).called(1);
    });
  });
  test('nextPage should return ResponseEntity', () async {
    const url = 'https://rickandmortyapi.com/api/character?page=2';
    when(() => mockRemoteDatasource.nextPage(url)).thenAnswer((_) async => mockResponseModel);

    final result = await repository.getNextPage(url);

    expect(result, isA<ResponseEntity>());
    expect(result.infoEntity?.pages, 42);
    expect(result.characterEntity?.name, '');
    expect(result.charactersEntity?.first.name, 'Toxic Rick');

    verify(() => mockRemoteDatasource.nextPage(url)).called(1);
  });
  test('prevPage should return ResponseEntity', () async {
    const url = 'https://rickandmortyapi.com/api/character?page=1';
    when(() => mockRemoteDatasource.prevPage(url)).thenAnswer((_) async => mockResponseModel);

    final result = await repository.getPrevPage(url);

    expect(result, isA<ResponseEntity>());
    expect(result.infoEntity?.pages, 42);
    expect(result.characterEntity?.name, '');
    expect(result.charactersEntity?.first.name, 'Toxic Rick');

    verify(() => mockRemoteDatasource.prevPage(url)).called(1);
  });
  test('getMultipleCharacters should return ResponseEntity', () async {
    final ids = [1, 2, 3];
    when(() => mockRemoteDatasource.getMultipleCharacters(ids)).thenAnswer((_) async => mockResponseModel);

    final result = await repository.getMultipleCharacters(ids);

    expect(result, isA<ResponseEntity>());
    expect(result.infoEntity?.count, 826);
    expect(result.characterEntity?.name, '');
    expect(result.charactersEntity?.first.name, 'Toxic Rick');

    verify(() => mockRemoteDatasource.getMultipleCharacters(ids)).called(1);
  });
  test('getCharacterById should return ResponseEntity', () async {
    const id = 1;
    when(() => mockRemoteDatasource.getMultipleCharacters([id])).thenAnswer((_) async => mockResponseModel);

    final result = await repository.getMultipleCharacters([id]);

    expect(result, isA<ResponseEntity>());
    expect(result.infoEntity?.count, 826);
    expect(result.characterEntity?.name, '');
    expect(result.charactersEntity?.first.name, 'Toxic Rick');

    verify(() => mockRemoteDatasource.getMultipleCharacters([id])).called(1);
  });
}
