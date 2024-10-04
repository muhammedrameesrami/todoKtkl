import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../controller/todoController.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final Todocontroller _todocontroller;
  TodoBloc({required Todocontroller controller})
      : _todocontroller = controller,
        super(TodoInitial()) {
    on<AddSubTaskEvent>(addSubtask);
    on<UpdateSubTaskEvent>(updateSubTask);
  }

  addSubtask(AddSubTaskEvent event, Emitter<TodoState> state) async {
    final res = await _todocontroller.addSubTask(
        taskId: event.taskId, task: event.task);
    res.fold(
      (l) => state(ToDoFailure(error: l.message)),
      (r) => state(ToDoSuccess(message: 'added')),
    );
  }

  updateSubTask(UpdateSubTaskEvent event, Emitter<TodoState> state) async {
    final res = await _todocontroller.updatetask(
        subtaskId: event.subTaskId, );
    res.fold(
      (l) => state(ToDoFailure(error: l.message)),
      (r) => state(ToDoSuccess(message: 'update success')),
    );
  }
}
