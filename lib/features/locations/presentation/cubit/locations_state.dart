part of 'locations_cubit.dart';

abstract class LocationsState extends Equatable {
  const LocationsState();

  @override
  List<Object> get props => [];
}

class LocationsInitial extends LocationsState {}

class LocationsLoading extends LocationsState {}

class LocationLoaded extends LocationsState {
  final ResponseEntity responseEntity;
  final int page;

  const LocationLoaded({
    required this.responseEntity,
    required this.page,
  });
}

class LocationError extends LocationsState {
  final String? msgError;

  const LocationError({required this.msgError});
}
