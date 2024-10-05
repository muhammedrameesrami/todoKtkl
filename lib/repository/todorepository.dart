import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:todoapp/core/typedef.dart';

import '../core/failure.dart';

class Todorepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  Todorepository(
      {required FirebaseAuth firebaseAuth,
      required FirebaseFirestore firestore})
      : _firebaseAuth = firebaseAuth,
        _firestore = firestore;

  Future<Either<Failure, String>> addSubtask(
      {required String task, required String taskId}) async {
    try {
      await FirebaseFirestore.instance.collection('subtasks').add({
        'task': task,
        'isCompleted': false,
        'taskId': taskId,
      });
      return right('succesfully added');
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, String>> updateTask({
    required String subtaskId,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('subtasks')
          .doc(subtaskId)
          .update({
        'isCompleted': true,
      });
      return right('updated added');
    } catch (e) {
      print('aaaaaaaa $e');
      return left(Failure(e.toString()));
    }
  }
}
