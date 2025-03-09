import 'package:rick_morty_api/features/characters/domain/entities/response_entity.dart';

abstract class CharactersRepository {
  Future<ResponseEntity> getCharacterResponse();
  Future<ResponseEntity> getNextPage(String url);
  Future<ResponseEntity> getPrevPage(String url);
}
