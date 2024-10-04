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
      // Attempt to sign in using Firebase authentication
      final result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('email', email);
      // Check if the sign-in was successful
      if (result.user == null) {
        // Return failure in case no user is found
        return left(Failure('User not found'));
      }
      // Query Firestore for the user's data based on their email
      final checkEmployeePresence = await FirebaseFirestore.instance
          .collection('user')
          .where("email", isEqualTo: result.user!.email)
          .get();

      // If no matching user data is found, return failure
      if (checkEmployeePresence.docs.isEmpty) {
        return left(Failure('No matching user found in database'));
      } else {
        // Convert the document data into a UserModel and return success
        final employee = UserModel.fromMap(
            checkEmployeePresence.docs.first.data() as Map<String, dynamic>);
        // Return the UserModel, including the password
        return right(employee.copyWith(password: password));
      }
    } on FirebaseAuthException catch (e) {
      // Handle Firebase authentication errors and return a failure
      return left(Failure(e.message ?? 'Authentication error'));
    } catch (e) {
      // Catch any other errors and return a failure
      return left(Failure(e.toString()));
    }
  }

}