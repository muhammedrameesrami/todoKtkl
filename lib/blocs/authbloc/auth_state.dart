part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthSuccess extends AuthState{
 UserModel model;
  AuthSuccess({required this.model});
}

final class AuthFailure extends AuthState{
 final String error;
  AuthFailure({required this.error});
}

final class AuthLoading extends AuthState{}