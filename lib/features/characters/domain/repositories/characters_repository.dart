import '../entities/response_entity.dart';

abstract class CharactersRepository {
  Future<ResponseEntity> getCharacterResponse();
  Future<ResponseEntity> getNextPage(String url);
  Future<ResponseEntity> getPrevPage(String url);
  Future<ResponseEntity> getMultipleCharacters(List<int> ids);
}
