import 'package:bloc/bloc.dart';
import '../../domain/usecases/multiple_characters_usecase.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/response_entity.dart';

part 'multiple_characters_state.dart';

class MultipleCharactersCubit extends Cubit<MultipleCharactersState> {
  final MultipleCharactersUsecase multipleCharactersUsecase;

  MultipleCharactersCubit(this.multipleCharactersUsecase) : super(MultipleCharactersInitial());

  Future<void> fetchMultipleCharacters(List<int> ids) async {
    try {
      emit(MultipleCharactersLoading());
      final response = await multipleCharactersUsecase.call(ids);
      emit(MultipleCharactersLoaded(
        responseEntity: response,
      ));
    } catch (e) {
      emit(
        MultipleCharactersError(message: 'Erro ao carregar'),
      );
    }
  }
}
