import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_morty_api/features/characters/domain/usecases/characters_usecase.dart';
import 'package:rick_morty_api/features/characters/presentation/cubit/characters_cubit.dart';
import 'package:rick_morty_api/features/characters/data/models/response_model.dart';

import '../../../../mock/character_mock.dart';

class MockCharactersUsecase extends Mock implements CharactersUsecase {}

void main() {
  late MockCharactersUsecase mockUsecase;
  late CharactersCubit cubit;

  final mockResponseEntity = ResponseModel.fromJson(characterResponseFromJson).toEntity();

  setUp(() {
    mockUsecase = MockCharactersUsecase();
    cubit = CharactersCubit(mockUsecase);
  });

  test('initial state should be CharactersInitial', () {
    expect(cubit.state, CharactersInitial());
  });

  blocTest<CharactersCubit, CharactersState>(
    'emit [CharactersLoading, CharactersLoaded] when getCharactersResponse is called successfully',
    build: () {
      when(() => mockUsecase.call()).thenAnswer((_) async => mockResponseEntity);
      return cubit;
    },
    act: (cubit) => cubit.getCharacter(),
    expect: () => [
      isA<CharactersLoading>(),
      isA<CharactersLoaded>()
          .having((state) => state.page, 'page', 1)
          .having((state) => state.responseEntity, 'responseEntity', mockResponseEntity),
    ],
  );
  blocTest<CharactersCubit, CharactersState>(
    'emit [CharactersLoading, CharactersError] when getCharactersResponse fails',
    build: () {
      when(() => mockUsecase.call()).thenThrow(Exception('Failed to load characters'));
      return cubit;
    },
    act: (cubit) => cubit.getCharacter(),
    expect: () => [
      isA<CharactersLoading>(),
      isA<CharactersError>().having(
        (state) => state.msgError,
        'message',
        'Erro ao carregar personagens: Exception: Failed to load characters',
      ),
    ],
  );
  blocTest<CharactersCubit, CharactersState>(
    'emit [CharactersLoading, CharactersLoaded] when getNextPage is called successfully',
    build: () {
      when(() => mockUsecase.getNextPage(any())).thenAnswer((_) async => mockResponseEntity);
      cubit.nextPage = 'https://rickandmortyapi.com/api/character?page=2';
      cubit.currentPage = 1;
      return cubit;
    },
    act: (cubit) => cubit.getNextPage(),
    expect: () => [
      isA<CharactersLoading>(),
      isA<CharactersLoaded>()
          .having((state) => state.page, 'page', 2)
          .having((state) => state.responseEntity, 'responseEntity', mockResponseEntity),
    ],
  );
  blocTest<CharactersCubit, CharactersState>(
    'emit [CharactersLoading, CharactersError] when getNextPage fails',
    build: () {
      when(() => mockUsecase.getNextPage(any())).thenThrow(Exception('Failed to load next page'));
      cubit.nextPage = 'https://rickandmortyapi.com/api/character?page=2';
      return cubit;
    },
    act: (cubit) => cubit.getNextPage(),
    expect: () => [
      isA<CharactersLoading>(),
      isA<CharactersError>().having(
        (state) => state.msgError,
        'message',
        contains('Failed to load next page'),
      ),
    ],
  );

  blocTest<CharactersCubit, CharactersState>(
    'emit [CharactersLoading, CharactersLoaded] when getPreviousPage is called successfully',
    build: () {
      when(() => mockUsecase.getPrevPage(any())).thenAnswer((_) async => mockResponseEntity);
      cubit.prevPage = 'https://rickandmortyapi.com/api/character?page=1';
      cubit.currentPage = 2;
      return cubit;
    },
    act: (cubit) => cubit.getPrevPage(),
    expect: () => [
      isA<CharactersLoading>(),
      isA<CharactersLoaded>()
          .having((state) => state.page, 'page', 1)
          .having((state) => state.responseEntity, 'responseEntity', mockResponseEntity),
    ],
  );

  blocTest<CharactersCubit, CharactersState>(
    'emit [CharactersLoading, CharactersError] when getPreviousPage fails',
    build: () {
      when(() => mockUsecase.getPrevPage(any())).thenThrow(Exception('Failed to load previous page'));

      cubit.prevPage = 'https://rickandmortyapi.com/api/character?page=1';
      return cubit;
    },
    act: (cubit) => cubit.getPrevPage(),
    expect: () => [
      isA<CharactersLoading>(),
      isA<CharactersError>().having(
        (state) => state.msgError,
        'message',
        contains('Failed to load previous page'),
      ),
    ],
  );

  tearDown(() {
    cubit.close();
  });
  test('close should call super.close', () {
    expect(cubit.close(), completes);
  });
}
