// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/common/common.dart';
import 'package:weather_app/common/session_manager.dart';
import 'package:weather_app/dio_injector/navigation_service.dart';
import 'package:weather_app/dio_injector/setup_locator.dart';
import 'package:weather_app/models/user_model.dart';
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
    on<OnForgotPassword>(_onForgotPassword);
  }

  BuildContext context = _nav.navKey.currentContext!;

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
      UserModel user = await AuthFirebase.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Session.set("user", jsonEncode(user.toJson()));
      context.go("/");
    } on FirebaseAuthException catch (e) {
      Common.modalInfo(
        context,
        title: e.message ?? "Something went wrong !",
        message: "Error",
      );
    }
  }

  void _onLoginPhoneNumber(
      OnLoginPhoneNumber event, Emitter<LoginState> emit) async {
    try {
      await AuthFirebase.verifyPhoneNumber(context, event.val);
    } on FirebaseAuthException catch (e) {
      Common.modalInfo(
        context,
        title: e.message ?? "Something went wrong !",
        message: "Error",
      );
    }
  }

  void _onLoginGoogle(OnLoginGoogle event, Emitter<LoginState> emit) async {
    try {
      UserModel user = await AuthFirebase.signInWithGoogle(context);
      Session.set("user", jsonEncode(user.toJson()));
      context.go("/");
    } on FirebaseAuthException catch (e) {
      Common.modalInfo(
        context,
        title: e.message ?? "Something went wrong !",
        message: "Error",
      );
    }
  }

  void _onForgotPassword(
      OnForgotPassword event, Emitter<LoginState> emit) async {
    try {
      await AuthFirebase.sendPasswordResetEmail(event.val);
    } on FirebaseAuthException catch (e) {
      Common.modalInfo(
        context,
        title: e.message ?? "Something went wrong !",
        message: "Error",
      );
    }
  }
}
