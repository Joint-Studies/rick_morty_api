import 'package:equatable/equatable.dart';
import 'package:rick_morty_api/features/locations/domain/entities/info_entity.dart';

import 'package:rick_morty_api/features/locations/domain/entities/location_entity.dart';

class ResponseEntity extends Equatable {
  final InfoEntity? infoEntity;
  final List<LocationEntity>? locationEntity;

  const ResponseEntity({
    this.infoEntity,
    this.locationEntity,
  });

  @override
  List<Object?> get props => [
        infoEntity,
        locationEntity,
      ];
}
