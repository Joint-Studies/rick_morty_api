import 'package:equatable/equatable.dart';

import '../../domain/entities/location_entity.dart';

class LocationModel extends Equatable {
  final int? id;
  final String? name;
  final String? type;
  final String? dimension;
  final List<String>? residents;
  final String? url;
  final String? created;

  const LocationModel({
    this.id,
    this.name,
    this.type,
    this.dimension,
    this.residents,
    this.url,
    this.created,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        id: json['id'] ?? 0,
        name: json['name'] ?? '',
        type: json['type'] ?? '',
        dimension: json['dimension'] ?? '',
        residents: (json['residents'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
        url: json['url'] ?? '',
        created: json['created'] ?? '',
      );

  LocationEntity toEntity() => LocationEntity(
        id: id,
        name: name,
        type: type,
        dimension: dimension,
        residents: residents,
        url: url,
        created: created,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        type,
        dimension,
        residents,
        url,
        created,
      ];
}
