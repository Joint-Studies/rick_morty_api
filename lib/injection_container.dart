import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'features/characters/domain/usecases/characters_usecase.dart';
import 'features/characters/presentation/cubit/characters_cubit.dart';
import 'core/api/dio_client.dart';
import 'features/characters/data/datasources/characters_remote_datasource.dart';
import 'features/characters/data/repositories/characters_repository_impl.dart';
import 'features/characters/domain/repositories/characters_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerSingleton(Dio());
  sl.registerSingleton<DioClient>(DioClientImpl());

  sl.registerSingleton<CharactersRemoteDatasource>(
    CharactersRemoteDatasourceImpl(
      dioClient: sl(),
    ),
  );

  sl.registerSingleton<CharactersRepository>(
    CharactersRepositoryImpl(
      remoteDatasource: sl(),
    ),
  );

  sl.registerSingleton(
    CharactersUsecase(
      charactersRepository: sl(),
    ),
  );
  sl.registerSingleton(
    CharactersCubit(
      sl(),
    ),
  );

  await sl.allReady();
}
