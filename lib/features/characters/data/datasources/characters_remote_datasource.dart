import 'package:rick_morty_api/core/api/dio_client.dart';
import 'package:rick_morty_api/core/api/endpoints.dart';
import 'package:dio/dio.dart';

import '../models/response_model.dart';

abstract class CharactersRemoteDatasource {
  Future<ResponseModel> getCharactersResponse();
  Future<ResponseModel> nextPage(String url);
  Future<ResponseModel> prevPage(String url);
  Future<ResponseModel> getMultipleCharacters(List<int> ids);
}

class CharactersRemoteDatasourceImpl implements CharactersRemoteDatasource {
  final DioClient dioClient;
  final dio = Dio();

  CharactersRemoteDatasourceImpl({
    required this.dioClient,
  });

  @override
  Future<ResponseModel> getCharactersResponse() async {
    final response = await dioClient.get(endpoint: Endpoints.character);
    return ResponseModel.fromJson(response);
  }

  @override
  Future<ResponseModel> nextPage(String url) async {
    final response = await dio.get(url);
    return ResponseModel.fromJson(response.data);
  }

  @override
  Future<ResponseModel> prevPage(String url) async {
    final response = await dio.get(url);
    return ResponseModel.fromJson(response.data);
  }

  @override
  Future<ResponseModel> getMultipleCharacters(List<int> ids) async {
    final String idsParam = ids.join(",");
    final response = await dio.get("https://rickandmortyapi.com/api/character/$idsParam");
    return ResponseModel.fromJson(response.data);
  }
}
