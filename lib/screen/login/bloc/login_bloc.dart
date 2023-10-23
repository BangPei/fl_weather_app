// ignore_for_file: avoid_print

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/dio_injector/navigation_service.dart';
import 'package:weather_app/dio_injector/setup_locator.dart';
import 'package:weather_app/service/auth_firebase.dart';

part 'login_event.dart';
part 'login_state.dart';

final NavigationService _nav = locator<NavigationService>();

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<OnChangedEmailOrPhone>(_onChangedEmailOrPhone);
    on<OnChangedPassword>(_onChangedPassword);
    on<OnLogin>(_onLogin);
    on<OnLoginPhoneNumber>(_onLoginPhoneNumber);
    on<OnLoginGoogle>(_onLoginGoogle);
  }

  void _onChangedEmailOrPhone(
      OnChangedEmailOrPhone event, Emitter<LoginState> emit) {
    String email = state.email ?? "";
    email = event.val;
    emit(state.copyWith(email: email));
  }

  void _onChangedPassword(OnChangedPassword event, Emitter<LoginState> emit) {
    String password = state.password ?? "";
    password = event.val;
    emit(state.copyWith(password: password));
  }

  void _onLogin(OnLogin event, Emitter<LoginState> emit) async {
    String email = state.email ?? "";
    String password = state.password ?? "";
    try {
      await AuthFirebase.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  void _onLoginPhoneNumber(
      OnLoginPhoneNumber event, Emitter<LoginState> emit) async {
    try {
      await AuthFirebase.verifyPhoneNumber(
          _nav.navKey.currentContext!, state.phoneNumber!);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  void _onLoginGoogle(OnLoginGoogle event, Emitter<LoginState> emit) async {
    try {
      AuthFirebase.signInWithGoogle(_nav.navKey.currentContext!);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}
