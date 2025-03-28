import 'package:rick_morty_api/features/characters/data/models/response_model.dart';

final characterResponse = ResponseModel.fromJson(characterResponseFromJson);
final characterResponseEntity = characterResponse.toEntity();
const characterResponseFromJson = {
  "info": {"count": 826, "pages": 42, "next": "https://rickandmortyapi.com/api/character?page=2", "prev": null},
  "results": [
    {
      "id": 361,
      "name": "Toxic Rick",
      "status": "Dead",
      "species": "Humanoid",
      "type": "Rick's Toxic Side",
      "gender": "Male",
      "origin": {"name": "Alien Spa", "url": "https://rickandmortyapi.com/api/location/64"},
      "location": {"name": "Earth", "url": "https://rickandmortyapi.com/api/location/20"},
      "image": "https://rickandmortyapi.com/api/character/avatar/361.jpeg",
      "episode": ["https://rickandmortyapi.com/api/episode/27"],
      "url": "https://rickandmortyapi.com/api/character/361",
      "created": "2018-01-10T18:20:41.703Z"
    }
  ],
};
