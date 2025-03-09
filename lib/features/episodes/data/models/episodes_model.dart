import 'package:equatable/equatable.dart';
import '../../domain/entities/episodes_entity.dart';

class EpisodesModel extends Equatable {
  final int? id;
  final String? name;
  final String? airDate;
  final String? episode;
  final List<String?>? characters;
  final String? url;
  final String? created;

  const EpisodesModel({
    this.id,
    this.name,
    this.airDate,
    this.episode,
    this.characters,
    this.url,
    this.created,
  });

  factory EpisodesModel.fromJson(Map<String, dynamic> json) => EpisodesModel(
        id: json['id'] ?? 0,
        name: json['name'] ?? '',
        airDate: json['air_date'] ?? '',
        episode: json['episode'] ?? '',
        characters: json['characters'].cast<String>() ?? '',
        url: json['url'] ?? '',
        created: json['created'] ?? '',
      );

  EpisodesEntity toEntity() => EpisodesEntity(
        id: id,
        name: name,
        airDate: airDate,
        episode: episode,
        characters: characters,
        url: url,
        created: created,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        airDate,
        episode,
        characters,
        url,
        created,
      ];
}
