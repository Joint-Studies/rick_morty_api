import 'package:rick_morty_api/features/locations/data/datasources/location_remote_datasource.dart';
import 'package:rick_morty_api/features/locations/domain/entities/response_entity.dart';
import 'package:rick_morty_api/features/locations/domain/repositories/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationRemoteDatasource remoteDatasource;

  LocationRepositoryImpl({
    required this.remoteDatasource,
  });

  @override
  Future<ResponseEntity> getLocationResponse() async {
    final response = await remoteDatasource.getLocationResponse();
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
}
