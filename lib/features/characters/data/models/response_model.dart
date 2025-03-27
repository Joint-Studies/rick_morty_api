import 'package:equatable/equatable.dart';

import '../../domain/entities/response_entity.dart';
import 'characters_model.dart';
import 'info_model.dart';

class ResponseModel extends Equatable {
  final InfoModel? infoModel;
  final List<CharactersModel>? charactersModel;
  final CharactersModel? characterModel;

  const ResponseModel({
    required this.infoModel,
    required this.charactersModel,
    this.characterModel,
  });

  factory ResponseModel.fromJson(dynamic json) {
    if (json is List) {
      return ResponseModel(
        infoModel: null,
        charactersModel: json.map((e) => CharactersModel.fromJson(e)).toList(),
      );
    } else if (json is Map<String, dynamic>) {
      return ResponseModel(
        infoModel: json['info'] != null ? InfoModel.fromJson(json['info']) : null,
        characterModel: CharactersModel.fromJson(json),
        charactersModel:
            json['results'] != null ? (json['results'] as List).map((e) => CharactersModel.fromJson(e)).toList() : null,
      );
    }
    throw Exception("Formato inesperado da API: ${json.runtimeType}");
  }

  ResponseEntity toEntity() => ResponseEntity(
        infoEntity: infoModel?.toEntity(),
        charactersEntity: charactersModel?.map((e) => e.toEntity()).toList(),
        characterEntity: characterModel?.toEntity(),
      );

  @override
  List<Object?> get props => [
        infoModel,
        charactersModel,
      ];
}
