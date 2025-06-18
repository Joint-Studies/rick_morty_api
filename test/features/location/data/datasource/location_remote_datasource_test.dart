import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:rick_morty_api/core/api/dio_client.dart';
import 'package:rick_morty_api/core/api/endpoints.dart';
import 'package:rick_morty_api/features/locations/data/datasources/location_remote_datasource.dart';
import 'package:rick_morty_api/features/locations/data/models/response_model.dart';

import '../../../../mock/location_mock.dart';

class MockDioClient extends Mock implements DioClient {}

class MockDio extends Mock implements Dio {}

void main() {
  late MockDioClient mockDioClient;
  late MockDio mockDio;
  late LocationRemoteDatasourceImpl datasource;

  setUp(() {
    mockDioClient = MockDioClient();
    mockDio = MockDio();
    datasource = LocationRemoteDatasourceImpl(dioClient: mockDioClient);
    datasource = LocationRemoteDatasourceImpl(dioClient: mockDioClient, dio: mockDio);
  });

  group('LocationRemoteDatasourceImpl', () {
    test('getLocationResponse retorna ResponseModel', () async {
      when(() => mockDioClient.get(endpoint: Endpoints.location)).thenAnswer((_) async => locationResponseFromJson);

      final result = await datasource.getLocationResponse();

      expect(result, isA<ResponseModel>());
      expect(result.infoModel?.count, 126);
      expect(result.infoModel?.pages, 7);
      verify(() => mockDioClient.get(endpoint: Endpoints.location)).called(1);
    });

    test('nextPage retorna ResponseModel', () async {
      const url = 'https://rickandmortyapi.com/api/location?page=2';
      when(() => mockDio.get(url))
          .thenAnswer((_) async => Response(data: locationResponseFromJson, requestOptions: RequestOptions(path: url)));

      final result = await datasource.nextPage(url);

      expect(result, isA<ResponseModel>());
      expect(result.infoModel?.pages, 7);
      verify(() => mockDio.get(url)).called(1);
    });

    test('prevPage retorna ResponseModel', () async {
      const url = 'https://rickandmortyapi.com/api/location?page=1';
      when(() => mockDio.get(url))
          .thenAnswer((_) async => Response(data: locationResponseFromJson, requestOptions: RequestOptions(path: url)));

      final result = await datasource.prevPage(url);

      expect(result, isA<ResponseModel>());
      expect(result.locationModel?.first.name, "Earth (C-137)");
      verify(() => mockDio.get(url)).called(1);
    });
  });
}
