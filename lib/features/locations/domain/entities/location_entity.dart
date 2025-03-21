import 'package:equatable/equatable.dart';

class LocationEntity extends Equatable {
  final int? id;
  final String? name;
  final String? type;
  final String? dimension;
  final List<String>? residents;
  final String? url;
  final String? created;

  const LocationEntity({
    this.id,
    this.name,
    this.type,
    this.dimension,
    this.residents,
    this.url,
    this.created,
  });

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
