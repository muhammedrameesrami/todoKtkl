part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class loginEvent extends AuthEvent{
  final String email;
  final String password;
  loginEvent({required this.email,required this.password});
}