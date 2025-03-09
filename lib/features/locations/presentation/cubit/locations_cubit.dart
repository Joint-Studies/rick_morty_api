import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'locations_state.dart';

class LocationsCubit extends Cubit<LocationsState> {
  LocationsCubit() : super(LocationsInitial());
}
