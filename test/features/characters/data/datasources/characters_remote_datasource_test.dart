import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_morty_api/core/api/dio_client.dart';
import 'package:rick_morty_api/core/api/endpoints.dart';
import 'package:rick_morty_api/features/characters/data/datasources/characters_remote_datasource.dart';
import 'package:rick_morty_api/features/characters/data/models/response_model.dart';

import '../../../../mock/character_mock.dart';

class MockDioClient extends Mock implements DioClient {}

class MockDio extends Mock implements Dio {}

void main() {
  late MockDioClient mockDioClient;
  late MockDio mockDio;
  late CharactersRemoteDatasourceImpl datasource;

  setUp(() {
    mockDioClient = MockDioClient();
    mockDio = MockDio();
    datasource = CharactersRemoteDatasourceImpl(dioClient: mockDioClient);
    datasource = CharactersRemoteDatasourceImpl(dioClient: mockDioClient, dio: mockDio);
  });

  group('CharactersRemoteDatasource', () {
    test('should return ResponseModel when getCharactersResponse is called successfully', () async {
      when(() => mockDioClient.get(endpoint: Endpoints.character)).thenAnswer((_) async => characterResponseFromJson);

      final result = await datasource.getCharactersResponse();

      expect(result, isA<ResponseModel>());
      expect(result.infoModel?.count, 826);
      expect(result.infoModel?.pages, 42);
      verify(() => mockDioClient.get(endpoint: Endpoints.character)).called(1);
    });
  });

  test('nextPage should return ResponseModel', () async {
    const url = 'https://rickandmortyapi.com/api/character?page=2';
    when(() => mockDio.get(url))
        .thenAnswer((_) async => Response(data: characterResponseFromJson, requestOptions: RequestOptions(path: url)));

    final result = await datasource.nextPage(url);

    expect(result, isA<ResponseModel>());
    expect(result.infoModel?.pages, 42);
    verify(() => mockDio.get(url)).called(1);
  });

  test('prevPage should return ResponseModel', () async {
    const url = 'https://rickandmortyapi.com/api/character?page=1';
    when(() => mockDio.get(url))
        .thenAnswer((_) async => Response(data: characterResponseFromJson, requestOptions: RequestOptions(path: url)));

    final result = await datasource.prevPage(url);

    expect(result, isA<ResponseModel>());
    expect(result.infoModel?.pages, 42);
    verify(() => mockDio.get(url)).called(1);
  });
}
