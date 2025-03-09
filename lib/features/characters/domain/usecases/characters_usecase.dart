import '../entities/response_entity.dart';
import '../repositories/characters_repository.dart';

class CharactersUsecase {
  final CharactersRepository charactersRepository;

  CharactersUsecase({
    required this.charactersRepository,
  });

  Future<ResponseEntity> call() async {
    try {
      return await charactersRepository.getCharacterResponse();
    } catch (error) {
      rethrow;
    }
  }

  Future<ResponseEntity> getNextPage(String url) async {
    try {
      return await charactersRepository.getNextPage(url);
    } catch (error) {
      rethrow;
    }
  }

  Future<ResponseEntity> getPrevPage(String url) async {
    try {
      return await charactersRepository.getPrevPage(url);
    } catch (error) {
      rethrow;
    }
  }
}
