import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_morty_api/core/api/dio_client.dart';
import 'package:rick_morty_api/features/characters/data/datasources/characters_remote_datasource.dart';
import 'package:rick_morty_api/features/characters/data/models/characters_model.dart';
import 'package:rick_morty_api/features/characters/data/models/info_model.dart';
import 'package:rick_morty_api/features/characters/data/models/response_model.dart';

import '../../../../mock/character_mock.dart';

class DioMock extends Mock implements DioClient {}

void main() {
  late CharactersRemoteDatasourceImpl remoteDatasource;
  late DioMock dioMock;

  setUp(() {
    dioMock = DioMock();
    remoteDatasource = CharactersRemoteDatasourceImpl(dioClient: dioMock);
  });

  test(
    'Should show endpoints correctly ',
    () async {
      when(() => dioMock.get(endpoint: any(named: 'endpoint'))).thenAnswer((_) async => characterResponseFromJson);

      final response = await remoteDatasource.getCharactersResponse();

      expect(response, ResponseModel.fromJson(characterResponseFromJson));
      expect(response.charactersModel, isA<List<CharactersModel>>());
      expect(response.infoModel, isA<InfoModel>());
    },
  );
}
