import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_morty_api/features/characters/domain/entities/response_entity.dart';
import 'package:rick_morty_api/features/characters/domain/repositories/characters_repository.dart';
import 'package:rick_morty_api/features/characters/domain/usecases/characters_usecase.dart';
import 'package:rick_morty_api/features/characters/data/models/response_model.dart';
import 'package:rick_morty_api/features/characters/domain/usecases/multiple_characters_usecase.dart';

import '../../../../mock/character_mock.dart';

class MockCharactersRepository extends Mock implements CharactersRepository {}

void main() {
  late MockCharactersRepository mockRepository;
  late CharactersUsecase usecase;
  late MultipleCharactersUsecase multipleCharactersUsecase;

  setUp(() {
    mockRepository = MockCharactersRepository();
    usecase = CharactersUsecase(charactersRepository: mockRepository);
    multipleCharactersUsecase = MultipleCharactersUsecase(charactersRepository: mockRepository);
  });

  final charactersResponseModel = ResponseModel.fromJson(characterResponseFromJson);
  final characterResponseEntity = charactersResponseModel.toEntity();

  group('CharactersUsecase', () {
    test('call() should return ResponseEntity', () async {
      when(() => mockRepository.getCharacterResponse()).thenAnswer((_) async => characterResponseEntity);

      final result = await usecase.call();

      expect(result, isA<ResponseEntity>());
      expect(result.infoEntity?.count, 826);
      expect(result.characterEntity?.name, '');
      expect(result.charactersEntity?.first.name, 'Toxic Rick');

      verify(() => mockRepository.getCharacterResponse()).called(1);
    });
    test('nextPage() should return ResponseEntity', () async {
      const url = 'https://rickandmortyapi.com/api/character?page=2';
      when(() => mockRepository.getNextPage(url)).thenAnswer((_) async => characterResponseEntity);

      final result = await usecase.getNextPage(url);

      expect(result, isA<ResponseEntity>());
      expect(result.infoEntity?.pages, 42);
      expect(result.characterEntity?.name, '');
      expect(result.charactersEntity?.first.name, 'Toxic Rick');

      verify(() => mockRepository.getNextPage(url)).called(1);
    });
    test('prevPage() should return ResponseEntity', () async {
      const url = 'https://rickandmortyapi.com/api/character?page=1';
      when(() => mockRepository.getPrevPage(url)).thenAnswer((_) async => characterResponseEntity);

      final result = await usecase.getPrevPage(url);

      expect(result, isA<ResponseEntity>());
      expect(result.infoEntity?.pages, 42);
      expect(result.characterEntity?.name, '');
      expect(result.charactersEntity?.first.name, 'Toxic Rick');

      verify(() => mockRepository.getPrevPage(url)).called(1);
    });
    test('getMultipleCharacters() should return ResponseEntity', () async {
      const ids = [1, 2, 3];
      when(() => mockRepository.getMultipleCharacters(ids)).thenAnswer((_) async => characterResponseEntity);

      final result = await multipleCharactersUsecase(ids);

      expect(result, isA<ResponseEntity>());
      expect(result.infoEntity?.count, 826);
      expect(result.characterEntity?.name, '');
      expect(result.charactersEntity?.first.name, 'Toxic Rick');

      verify(() => mockRepository.getMultipleCharacters(ids)).called(1);
    });
  });
}
