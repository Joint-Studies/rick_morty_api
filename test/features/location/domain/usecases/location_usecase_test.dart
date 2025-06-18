import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_morty_api/features/locations/data/models/response_model.dart';
import 'package:rick_morty_api/features/locations/domain/entities/response_entity.dart';
import 'package:rick_morty_api/features/locations/domain/usecases/location_usecase.dart';
import 'package:rick_morty_api/features/locations/domain/repositories/location_repository.dart';

import '../../../../mock/location_mock.dart';

class MockLocationRepository extends Mock implements LocationRepository {}

void main() {
  late MockLocationRepository mockRepository;
  late LocationUsecase usecase;

  setUp(() {
    mockRepository = MockLocationRepository();
    usecase = LocationUsecase(locationRepository: mockRepository);
  });

  final locationResponseModel = ResponseModel.fromJson(locationResponseFromJson);
  final locationResponseEntity = locationResponseModel.toEntity();

  group('LocationUsecase', () {
    test('call() retorna ResponseEntity', () async {
      when(() => mockRepository.getLocationResponse()).thenAnswer((_) async => locationResponseEntity);

      final result = await usecase.call();

      expect(result, isA<ResponseEntity>());
      expect(result.infoEntity?.count, 126);
      verify(() => mockRepository.getLocationResponse()).called(1);
    });

    test('getNextPage retorna ResponseEntity', () async {
      const url = 'https://rickandmortyapi.com/api/location?page=2';
      when(() => mockRepository.getNextPage(url)).thenAnswer((_) async => locationResponseEntity);

      final result = await usecase.getNextPage(url);

      expect(result, isA<ResponseEntity>());
      expect(result.infoEntity?.next, equals(url));
      verify(() => mockRepository.getNextPage(url)).called(1);
    });

    test('getPrevPage retorna ResponseEntity', () async {
      const url = 'https://rickandmortyapi.com/api/location?page=1';
      when(() => mockRepository.getPrevPage(url)).thenAnswer((_) async => locationResponseEntity);

      final result = await usecase.getPrevPage(url);

      expect(result, isA<ResponseEntity>());
      expect(result.locationEntity?.first.name, equals("Earth (C-137)"));
      verify(() => mockRepository.getPrevPage(url)).called(1);
    });
  });
}
