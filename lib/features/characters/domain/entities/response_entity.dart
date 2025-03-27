import 'package:equatable/equatable.dart';
import 'characters_entity.dart';
import 'info_entity.dart';

class ResponseEntity extends Equatable {
  final InfoEntity? infoEntity;
  final List<CharactersEntity>? charactersEntity;
  final CharactersEntity? characterEntity;

  const ResponseEntity({
    this.infoEntity,
    this.charactersEntity,
    this.characterEntity,
  });
  @override
  List<Object?> get props => [
        infoEntity,
        charactersEntity,
        characterEntity,
      ];
}
