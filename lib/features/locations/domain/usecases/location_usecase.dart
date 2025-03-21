import '../entities/response_entity.dart';
import '../repositories/location_repository.dart';

class LocationUsecase {
  final LocationRepository locationRepository;

  LocationUsecase({
    required this.locationRepository,
  });

  Future<ResponseEntity> call() async {
    try {
      return await locationRepository.getLocationResponse();
    } catch (error) {
      rethrow;
    }
  }

  Future<ResponseEntity> getNextPage(String url) async {
    try {
      return await locationRepository.getNextPage(url);
    } catch (error) {
      rethrow;
    }
  }

  Future<ResponseEntity> getPrevPage(String url) async {
    try {
      return await locationRepository.getPrevPage(url);
    } catch (error) {
      rethrow;
    }
  }
}
