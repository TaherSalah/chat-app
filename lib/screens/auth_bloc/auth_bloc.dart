import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {


    on<AuthEvent>((event, emit) async {
      // TODO: implement event handler
      if (event is LoginEvent) {
        try {
          emit(LoginLoading());
          await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: event.email, password: event.password);
          emit(LoginSuccess());
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            print('No user found for that email.');
          } else if (e.code == 'wrong-password') {
            print('Wrong password provided for that user.');
          }
          print(e.toString());
        } catch (e) {
          emit(LoginFailure(errorMsg: e.toString()));
        }
      }
      if (event is RegisterEvent) {
        try {
          emit(RegisterLoading());
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: event.email, password: event.password);
          emit(RegisterSuccess());
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            print('The password provided is too weak.');
          } else if (e.code == 'email-already-in-use') {
            print('The account already exists for that email.');
          }
        } catch (e) {
          emit(RegisterFailure(errorMsg: e.toString()));
        }
      }
      if (event is ToggleEvent) {
        event.isActive = !event.isActive;
        emit(ToggleState(isActive: event.isActive));
      }
    });
  }

  
}
