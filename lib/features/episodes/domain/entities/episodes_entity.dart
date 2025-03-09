import 'package:equatable/equatable.dart';

class EpisodesEntity extends Equatable {
  final int? id;
  final String? name;
  final String? airDate;
  final String? episode;
  final List<String?>? characters;
  final String? url;
  final String? created;

  const EpisodesEntity({
    this.id,
    this.name,
    this.airDate,
    this.characters,
    this.url,
    this.episode,
    this.created,
  });

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
