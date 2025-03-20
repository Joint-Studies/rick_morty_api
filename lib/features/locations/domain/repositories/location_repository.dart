import '../entities/response_entity.dart';

abstract class LocationRepository {
  Future<ResponseEntity> getLocationResponse();
  Future<ResponseEntity> getNextPage(String url);
  Future<ResponseEntity> getPrevPage(String url);
}
