import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_morty_api/features/locations/data/models/response_model.dart';

import 'package:rick_morty_api/features/locations/domain/usecases/location_usecase.dart';
import 'package:rick_morty_api/features/locations/presentation/cubit/locations_cubit.dart';

import '../../../../mock/location_mock.dart';

class MockLocationUsecase extends Mock implements LocationUsecase {}

void main() {
  late MockLocationUsecase mockUsecase;
  late LocationsCubit cubit;

  final mockResponseEntity = ResponseModel.fromJson(locationResponseFromJson).toEntity();

  setUp(() {
    mockUsecase = MockLocationUsecase();
    cubit = LocationsCubit(mockUsecase);
  });

  test('estado inicial deve ser LocationsInitial', () {
    expect(cubit.state, isA<LocationsInitial>());
  });

  blocTest<LocationsCubit, LocationsState>(
    'emite [LocationsLoading, LocationLoaded] quando getLocationResponse é chamado com sucesso',
    build: () {
      when(() => mockUsecase.call()).thenAnswer((_) async => mockResponseEntity);
      return cubit;
    },
    act: (cubit) => cubit.getLocationResponse(),
    expect: () => [
      isA<LocationsLoading>(),
      isA<LocationLoaded>()
          .having((state) => state.page, 'page', 1)
          .having((state) => state.responseEntity, 'responseEntity', mockResponseEntity),
    ],
  );

  blocTest<LocationsCubit, LocationsState>(
    'emite [LocationsLoading, LocationError] quando getLocationResponse falha',
    build: () {
      when(() => mockUsecase.call()).thenThrow(Exception('Falha ao buscar'));
      return cubit;
    },
    act: (cubit) => cubit.getLocationResponse(),
    expect: () => [
      isA<LocationsLoading>(),
      isA<LocationError>().having((state) => state.msgError, 'msgError', 'Erro ao carregagar os Lugares'),
    ],
  );

  blocTest<LocationsCubit, LocationsState>(
    'emite [LocationsLoading, LocationLoaded] quando getNextPage é chamado e nextPage != null',
    build: () {
      when(() => mockUsecase.getNextPage(any())).thenAnswer((_) async => mockResponseEntity);
      cubit.nextPage = 'https://rickandmortyapi.com/api/location?page=2';
      return cubit;
    },
    act: (cubit) => cubit.getNextPage(),
    expect: () => [
      isA<LocationsLoading>(),
      isA<LocationLoaded>()
          .having((state) => state.page, 'page', 2)
          .having((state) => state.responseEntity, 'responseEntity', mockResponseEntity),
    ],
  );

  blocTest<LocationsCubit, LocationsState>(
    'não emite nada quando getNextPage é chamado e nextPage == null',
    build: () {
      cubit.nextPage = null;
      return cubit;
    },
    act: (cubit) => cubit.getNextPage(),
    expect: () => [],
  );

  blocTest<LocationsCubit, LocationsState>(
    'emite [LocationsLoading, LocationError] quando getNextPage lança exceção',
    build: () {
      when(() => mockUsecase.getNextPage(any())).thenThrow(Exception('Erro no nextPage'));
      cubit.nextPage = 'https://rickandmortyapi.com/api/location?page=2';
      return cubit;
    },
    act: (cubit) => cubit.getNextPage(),
    expect: () => [
      isA<LocationsLoading>(),
      isA<LocationError>().having((state) => state.msgError, 'msgError', contains('Erro no nextPage')),
    ],
  );

  blocTest<LocationsCubit, LocationsState>(
    'emite [LocationsLoading, LocationLoaded] quando getPrevPage é chamado e prevPage != null',
    build: () {
      when(() => mockUsecase.getPrevPage(any())).thenAnswer((_) async => mockResponseEntity);
      cubit.prevPage = 'https://rickandmortyapi.com/api/location?page=1';
      cubit.currentPage = 2;
      return cubit;
    },
    act: (cubit) => cubit.getPrevPage(),
    expect: () => [
      isA<LocationsLoading>(),
      isA<LocationLoaded>()
          .having((state) => state.page, 'page', 1)
          .having((state) => state.responseEntity, 'responseEntity', mockResponseEntity),
    ],
  );

  blocTest<LocationsCubit, LocationsState>(
    'não emite nada quando getPrevPage é chamado e prevPage == null',
    build: () {
      cubit.prevPage = null;
      return cubit;
    },
    act: (cubit) => cubit.getPrevPage(),
    expect: () => [],
  );

  blocTest<LocationsCubit, LocationsState>(
    'emite [LocationsLoading, LocationError] quando getPrevPage lança exceção',
    build: () {
      when(() => mockUsecase.getPrevPage(any())).thenThrow(Exception('Erro no prevPage'));
      cubit.prevPage = 'https://rickandmortyapi.com/api/location?page=1';
      return cubit;
    },
    act: (cubit) => cubit.getPrevPage(),
    expect: () => [
      isA<LocationsLoading>(),
      isA<LocationError>().having((state) => state.msgError, 'msgError', contains('Erro ao carregar página anterior')),
    ],
  );
}
