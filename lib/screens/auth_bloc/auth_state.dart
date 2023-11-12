part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {}

class LoginFailure extends AuthState {
  final String errorMsg;

  LoginFailure({required this.errorMsg});
}

class RegisterLoading extends AuthState {}

class RegisterSuccess extends AuthState {}

class RegisterFailure extends AuthState {
  final String errorMsg;

  RegisterFailure({required this.errorMsg});
}

// ignore: must_be_immutable
class ToggleState extends AuthState {
  bool isActive = true;

  ToggleState({required this.isActive});
}
