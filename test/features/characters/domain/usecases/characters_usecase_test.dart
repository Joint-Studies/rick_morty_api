import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_morty_api/features/characters/domain/repositories/characters_repository.dart';
import 'package:rick_morty_api/features/characters/domain/usecases/characters_usecase.dart';

import '../../../../mock/character_mock.dart';

class MockCharactersRepository extends Mock implements CharactersRepository {}

void main() {
  late CharactersUsecase usecase;
  late MockCharactersRepository repository;

  setUp(() {
    repository = MockCharactersRepository();
    usecase = CharactersUsecase(charactersRepository: repository);
  });

  test(
    'Should get the entity loaded when it comes from the repository',
    () async {
      when(() => repository.getCharacterResponse()).thenAnswer(
        (_) async => characterResponse.toEntity(),
      );

      final response = await usecase.call();

      expect(response, characterResponse.toEntity());
    },
  );
}
