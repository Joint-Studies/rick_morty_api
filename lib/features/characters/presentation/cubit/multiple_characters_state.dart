part of 'multiple_characters_cubit.dart';

abstract class MultipleCharactersState extends Equatable {
  @override
  List<Object> get props => [];
}

class MultipleCharactersInitial extends MultipleCharactersState {}

class MultipleCharactersLoading extends MultipleCharactersState {}

class MultipleCharactersLoaded extends MultipleCharactersState {
  final ResponseEntity responseEntity;

  MultipleCharactersLoaded({required this.responseEntity});
}

class MultipleCharactersError extends MultipleCharactersState {
  final String? message;

  MultipleCharactersError({required this.message});
}
