import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:rick_morty_api/features/characters/domain/usecases/multiple_characters_usecase.dart';
import 'package:rick_morty_api/features/characters/presentation/cubit/multiple_characters_cubit.dart';
import 'features/locations/data/datasources/location_remote_datasource.dart';
import 'features/locations/data/repositories/location_repository_impl.dart';
import 'features/locations/domain/repositories/location_repository.dart';
import 'features/locations/domain/usecases/location_usecase.dart';
import 'features/locations/presentation/cubit/locations_cubit.dart';
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

  sl.registerSingleton(
    MultipleCharactersUsecase(
      charactersRepository: sl(),
    ),
  );

  sl.registerSingleton(
    MultipleCharactersCubit(
      sl(),
    ),
  );

  // Location

  sl.registerSingleton<LocationRemoteDatasource>(
    LocationRemoteDatasourceImpl(
      dioClient: sl(),
    ),
  );

  sl.registerSingleton<LocationRepository>(
    LocationRepositoryImpl(
      remoteDatasource: sl(),
    ),
  );

  sl.registerSingleton(
    LocationUsecase(
      locationRepository: sl(),
    ),
  );

  sl.registerSingleton(
    LocationsCubit(
      sl(),
    ),
  );

  await sl.allReady();
}
