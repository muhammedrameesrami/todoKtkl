part of 'todo_bloc.dart';

@immutable
sealed class TodoState {}

final class TodoInitial extends TodoState {}

final class ToDoSuccess extends TodoState{
  final String message;
  ToDoSuccess({required this.message});
}

final class ToDoFailure extends TodoState{
  final String error;
  ToDoFailure({required this.error});
}

final class ToDoLoading extends TodoState{}