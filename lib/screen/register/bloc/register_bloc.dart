// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/common/session_manager.dart';
import 'package:weather_app/dio_injector/navigation_service.dart';
import 'package:weather_app/dio_injector/setup_locator.dart';
import 'package:weather_app/models/user_model.dart';
import 'package:weather_app/service/auth_firebase.dart';

part 'register_event.dart';
part 'register_state.dart';

final NavigationService _nav = locator<NavigationService>();

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(const RegisterState()) {
    on<OnChangedEmail>(_onChangedEmail);
    on<OnChangedPhone>(_onChangedPhone);
    on<OnChangedFullName>(_onChangedFullName);
    on<OnChangedPassword>(_onChangedPassword);
    on<OnRegisterWithEmail>(_onRegisterWithEmail);
    on<OnRegisterWithPhone>(_onRegisterWithPhone);
    on<OnRegisterFireStore>(_onRegisterFireStore);
  }

  void _onChangedEmail(OnChangedEmail event, Emitter<RegisterState> emit) {
    UserModel user = state.user ?? UserModel();
    user.email = event.val;
    emit(state.copyWith(user: user));
  }

  void _onChangedPhone(OnChangedPhone event, Emitter<RegisterState> emit) {
    UserModel user = state.user ?? UserModel();
    user.phoneNumber = event.val;
    emit(state.copyWith(user: user));
  }

  void _onChangedFullName(
      OnChangedFullName event, Emitter<RegisterState> emit) {
    UserModel user = state.user ?? UserModel();
    user.fullname = event.val;
    emit(state.copyWith(user: user));
  }

  void _onChangedPassword(
      OnChangedPassword event, Emitter<RegisterState> emit) {
    UserModel user = state.user ?? UserModel();
    user.password = event.val;
    emit(state.copyWith(user: user));
  }

  void _onRegisterWithEmail(
      OnRegisterWithEmail event, Emitter<RegisterState> emit) async {
    // String email = state.email ?? "";
    // String password = state.password ?? "";
    // try {
    //   await AuthFirebase.createUserWithEmailAndPassword(
    //     email: email,
    //     password: password,
    //   );
    //   await AuthFirebase.currUser?.updateDisplayName(state.fullName);
    // } on FirebaseAuthException catch (e) {
    //   print(e);
    // }
  }

  void _onRegisterWithPhone(
      OnRegisterWithPhone event, Emitter<RegisterState> emit) async {
    // String phone = state.phoneNumber ?? "";
    // try {
    //   await AuthFirebase.verifyPhoneNumber(_nav.navKey.currentContext!, phone);
    //   await AuthFirebase.currUser?.updateDisplayName(state.fullName);
    // } on FirebaseAuthException catch (e) {
    //   print(e);
    // }
  }

  void _onRegisterFireStore(
      OnRegisterFireStore event, Emitter<RegisterState> emit) async {
    UserModel user = state.user ?? UserModel();
    UserModel newUser = await AuthFirebase.registerUserFirestore(
        _nav.navKey.currentContext!, user);
    Session.set("user", jsonEncode(newUser.toJson()));
    _nav.navKey.currentContext!.go("/");
    emit(state.copyWith(user: newUser));
  }
}
