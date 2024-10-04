import 'package:fpdart/fpdart.dart';
import 'package:todoapp/repository/todorepository.dart';

import '../core/failure.dart';

class Todocontroller {
  final Todorepository _repository;


  Todocontroller({required Todorepository repository,})
      : _repository = repository;

  Future<Either<Failure, String>> addSubTask({required String taskId,required String task}) async {
   return await _repository.addSubtask(task: task, taskId: taskId);
  }

  Future<Either<Failure, String>> updatetask({required String subtaskId,}) async {
    return await _repository.updateTask( subtaskId: subtaskId);
  }
}