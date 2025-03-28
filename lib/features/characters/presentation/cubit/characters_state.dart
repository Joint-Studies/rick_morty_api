part of 'characters_cubit.dart';

abstract class CharactersState extends Equatable {
  const CharactersState();

  @override
  List<Object> get props => [];
}

class CharactersInitial extends CharactersState {}

class CharactersLoading extends CharactersState {}

class CharactersLoaded extends CharactersState {
  final ResponseEntity responseEntity;
  final int page;

  const CharactersLoaded({required this.responseEntity, required this.page});
}

class CharactersError extends CharactersState {
  final String? msgError;

  const CharactersError({required this.msgError});
}
