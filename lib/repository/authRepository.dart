import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/failure.dart';
import '../core/typedef.dart';
import '../models/userModel.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  AuthRepository({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  FutureEither<void> resetPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return right(null);
    } on FirebaseAuthException catch (e) {
      return left(Failure(e.message ?? 'Unknown error'));
    }
  }

  Future<Either<Failure, UserModel>> login(
      {required String email, required String password}) async {
    try {
      final result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      if (result.user == null) {
        return left(Failure('User not found'));
      }
      final checkEmployeePresence = await FirebaseFirestore.instance
          .collection('user')
          .where("email", isEqualTo: result.user!.email)
          .get();
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('id', checkEmployeePresence.docs.first.id);

      if (checkEmployeePresence.docs.isEmpty) {
        return left(Failure('No matching user found in database'));
      } else {
        final employee = UserModel.fromMap(
            checkEmployeePresence.docs.first.data() as Map<String, dynamic>);
        return right(employee.copyWith(password: password));
      }
    } on FirebaseAuthException catch (e) {
      return left(Failure(e.message ?? 'Authentication error'));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
