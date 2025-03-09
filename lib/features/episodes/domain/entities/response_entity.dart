import 'package:equatable/equatable.dart';
import 'package:rick_morty_api/features/episodes/domain/entities/episodes_entity.dart';
import 'package:rick_morty_api/features/episodes/domain/entities/info_entity.dart';

class ResponseEntity extends Equatable {
  final InfoEntity? infoEntity;
  final List<EpisodesEntity>? episodesEntity;

  const ResponseEntity({
    this.infoEntity,
    this.episodesEntity,
  });

  @override
  List<Object?> get props => [
        infoEntity,
        episodesEntity,
      ];
}
