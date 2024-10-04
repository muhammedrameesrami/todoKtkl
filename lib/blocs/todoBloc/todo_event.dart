part of 'todo_bloc.dart';

@immutable
sealed class TodoEvent {}

final class AddSubTaskEvent extends TodoEvent{
  final String task;
  final String taskId;
  AddSubTaskEvent({required this.taskId,required this.task});
}

final class UpdateSubTaskEvent extends TodoEvent{
  final String task;
  final String taskId;

  final subTaskId;
  UpdateSubTaskEvent({required this.taskId,required this.task,required this.subTaskId});
}