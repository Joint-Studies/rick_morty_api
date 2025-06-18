import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:rick_morty_api/features/locations/data/models/response_model.dart';
import 'package:rick_morty_api/features/locations/domain/entities/response_entity.dart';
import 'package:rick_morty_api/features/locations/data/datasources/location_remote_datasource.dart';
import 'package:rick_morty_api/features/locations/data/repositories/location_repository_impl.dart';

import '../../../../mock/location_mock.dart'; // seu mock JSON com locationResponseFromJson

class MockLocationRemoteDatasource extends Mock implements LocationRemoteDatasource {}

void main() {
  late LocationRepositoryImpl repository;
  late MockLocationRemoteDatasource mockRemoteDatasource;

  setUp(() {
    mockRemoteDatasource = MockLocationRemoteDatasource();
    repository = LocationRepositoryImpl(remoteDatasource: mockRemoteDatasource);
  });

  final mockResponseModel = ResponseModel.fromJson(locationResponseFromJson);

  group('LocationRepositoryImpl', () {
    test('getLocationResponse retorna ResponseEntity', () async {
      when(() => mockRemoteDatasource.getLocationResponse()).thenAnswer((_) async => mockResponseModel);

      final result = await repository.getLocationResponse();

      expect(result, isA<ResponseEntity>());
      expect(result.infoEntity?.count, 126);
      expect(result.locationEntity?.first.name, "Earth (C-137)");

      verify(() => mockRemoteDatasource.getLocationResponse()).called(1);
    });

    test('getNextPage retorna ResponseEntity', () async {
      const url = 'https://rickandmortyapi.com/api/location?page=2';
      when(() => mockRemoteDatasource.nextPage(url)).thenAnswer((_) async => mockResponseModel);

      final result = await repository.getNextPage(url);

      expect(result, isA<ResponseEntity>());
      expect(result.infoEntity?.next, equals(url));
      verify(() => mockRemoteDatasource.nextPage(url)).called(1);
    });

    test('getPrevPage retorna ResponseEntity', () async {
      const url = 'https://rickandmortyapi.com/api/location?page=1';
      when(() => mockRemoteDatasource.prevPage(url)).thenAnswer((_) async => mockResponseModel);

      final result = await repository.getPrevPage(url);

      expect(result, isA<ResponseEntity>());
      expect(result.locationEntity?.first.id, 1);
      verify(() => mockRemoteDatasource.prevPage(url)).called(1);
    });
  });
}
