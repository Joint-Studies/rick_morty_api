import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/response_entity.dart';
import '../../domain/usecases/location_usecase.dart';

part 'locations_state.dart';

class LocationsCubit extends Cubit<LocationsState> {
  final LocationUsecase usecase;
  String? nextPage;
  String? prevPage;
  int currentPage = 1;
  LocationsCubit(this.usecase) : super(LocationsInitial());

  Future<void> getLocationResponse() async {
    try {
      emit(LocationsLoading());
      final response = await usecase.call();
      nextPage = response.infoEntity?.next;
      currentPage = 1;

      emit(LocationLoaded(responseEntity: response, page: currentPage));
    } catch (e) {
      emit(LocationError(msgError: 'Erro ao carregagar os Lugares'));
    }
  }

  Future<void> getNextPage() async {
    if (nextPage != null) {
      try {
        emit(LocationsLoading());
        final response = await usecase.getNextPage(nextPage!);
        nextPage = response.infoEntity?.next;
        prevPage = response.infoEntity?.prev;
        currentPage++;

        emit(LocationLoaded(responseEntity: response, page: currentPage));
      } catch (e) {
        emit(LocationError(msgError: e.toString()));
      }
    }
  }

  Future<void> getPrevPage() async {
    if (prevPage != null) {
      try {
        emit(LocationsLoading());
        final response = await usecase.getPrevPage(prevPage!);

        nextPage = response.infoEntity?.next;
        prevPage = response.infoEntity?.prev;
        currentPage--;

        emit(LocationLoaded(responseEntity: response, page: currentPage));
      } catch (e) {
        emit(LocationError(msgError: 'Erro ao carregar página anterior: ${e.toString()}'));
      }
    }
  }
}
