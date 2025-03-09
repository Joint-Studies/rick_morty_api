import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/response_entity.dart';
import '../../domain/usecases/characters_usecase.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersUsecase usecase;
  String? nextPage;
  String? prevPage;
  int currentPage = 1;

  CharactersCubit(this.usecase) : super(CharactersInitial());

  Future<void> getCharacter() async {
    try {
      emit(CharactersLoading());
      final response = await usecase.call();
      nextPage = response.infoEntity?.next;
      currentPage = 1;

      emit(CharactersLoaded(responseEntity: response, page: currentPage));
    } catch (e) {
      emit(CharactersError(msgError: 'Erro ao carregar personagens: ${e.toString()}'));
    }
  }

  Future<void> getNextPage() async {
    if (nextPage != null) {
      try {
        emit(CharactersLoading());

        final response = await usecase.getNextPage(nextPage!);
        nextPage = response.infoEntity?.next;
        prevPage = response.infoEntity?.prev;
        currentPage++;

        emit(CharactersLoaded(responseEntity: response, page: currentPage));
      } catch (e) {
        emit(CharactersError(msgError: e.toString()));
      }
    } else {}
  }

  Future<void> getPrevPage() async {
    if (prevPage != null) {
      try {
        emit(CharactersLoading());
        final response = await usecase.getPrevPage(prevPage!);

        nextPage = response.infoEntity?.next;
        prevPage = response.infoEntity?.prev;
        currentPage--;

        emit(CharactersLoaded(responseEntity: response, page: currentPage));
      } catch (e) {
        emit(CharactersError(msgError: 'Erro ao carregar página anterior: ${e.toString()}'));
      }
    }
  }
}
