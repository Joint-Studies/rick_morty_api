import 'package:dio/dio.dart';
import '../../../../core/api/dio_client.dart';
import '../../../../core/api/endpoints.dart';
import '../models/response_model.dart';

abstract class LocationRemoteDatasource {
  Future<ResponseModel> getLocationResponse();
  Future<ResponseModel> nextPage(String url);
  Future<ResponseModel> prevPage(String url);
}

class LocationRemoteDatasourceImpl implements LocationRemoteDatasource {
  final DioClient dioClient;
  final Dio dio;

  LocationRemoteDatasourceImpl({
    required this.dioClient,
    Dio? dio,
  }) : dio = dio ?? Dio();

  @override
  Future<ResponseModel> getLocationResponse() async {
    final response = await dioClient.get(endpoint: Endpoints.location);
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
}
