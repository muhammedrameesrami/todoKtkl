import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fpdart/fpdart.dart';
import 'package:todoapp/models/userModel.dart';

import '../core/failure.dart';
import '../core/typedef.dart';
import '../repository/authRepository.dart';

class AuthController {
  final AuthRepository _repository;


  AuthController({required AuthRepository repository,})
      : _repository = repository;

  resetPassword(
      {required String number, required BuildContext context,required String email}) async {
      _repository.resetPassword( email: email);
  }

  Future<Either<Failure, UserModel>> login({required String email,required String password})async{
 return  await _repository.login(email: email, password: password);
}


}