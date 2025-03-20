import 'package:equatable/equatable.dart';
import 'package:rick_morty_api/features/locations/data/models/info_model.dart';
import 'package:rick_morty_api/features/locations/data/models/location_model.dart';
import 'package:rick_morty_api/features/locations/domain/entities/response_entity.dart';

class ResponseModel extends Equatable {
  final InfoModel? infoModel;
  final List<LocationModel>? locationModel;

  const ResponseModel({
    required this.infoModel,
    required this.locationModel,
  });

  factory ResponseModel.fromJson(dynamic json) => ResponseModel(
        infoModel: InfoModel.fromJson(json['info']),
        locationModel:
            json['results'] != null ? (json['results'] as List).map((e) => LocationModel.fromJson(e)).toList() : null,
      );

  ResponseEntity toEntity() => ResponseEntity(
        infoEntity: infoModel?.toEntity(),
        locationEntity: locationModel?.map((e) => e.toEntity()).toList(),
      );

  @override
  List<Object?> get props => [
        infoModel,
        locationModel,
      ];
}
