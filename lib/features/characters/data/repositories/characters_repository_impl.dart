import '../datasources/characters_remote_datasource.dart';
import '../../domain/entities/response_entity.dart';
import '../../domain/repositories/characters_repository.dart';

class CharactersRepositoryImpl implements CharactersRepository {
  final CharactersRemoteDatasource remoteDatasource;

  CharactersRepositoryImpl({
    required this.remoteDatasource,
  });

  @override
  Future<ResponseEntity> getCharacterResponse() async {
    final response = await remoteDatasource.getCharactersResponse();
    return response.toEntity();
  }

  @override
  Future<ResponseEntity> getNextPage(String url) async {
    final response = await remoteDatasource.nextPage(url);
    return response.toEntity();
  }

  @override
  Future<ResponseEntity> getPrevPage(String url) async {
    final response = await remoteDatasource.prevPage(url);
    return response.toEntity();
  }

  @override
  Future<ResponseEntity> getMultipleCharacters(List<int> ids) async {
    final response = await remoteDatasource.getMultipleCharacters(ids);
    return response.toEntity();
  }
}
