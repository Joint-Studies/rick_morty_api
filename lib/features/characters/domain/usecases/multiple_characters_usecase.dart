import 'package:rick_morty_api/features/characters/domain/entities/response_entity.dart';
import 'package:rick_morty_api/features/characters/domain/repositories/characters_repository.dart';

class MultipleCharactersUsecase {
  final CharactersRepository charactersRepository;

  MultipleCharactersUsecase({required this.charactersRepository});

  Future<ResponseEntity> call(List<int> ids) async {
    try {
      return await charactersRepository.getMultipleCharacters(ids);
    } catch (error) {
      rethrow;
    }
  }
}
