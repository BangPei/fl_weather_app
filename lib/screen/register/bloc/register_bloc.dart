import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/dio_injector/navigation_service.dart';
import 'package:weather_app/dio_injector/setup_locator.dart';
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
  }

  void _onChangedEmail(OnChangedEmail event, Emitter<RegisterState> emit) {
    String email = state.email ?? "";
    email = event.val;
    emit(state.copyWith(email: email));
  }

  void _onChangedPhone(OnChangedPhone event, Emitter<RegisterState> emit) {
    String phoneNumber = state.phoneNumber ?? "";
    phoneNumber = event.val;
    emit(state.copyWith(phoneNumber: phoneNumber));
  }

  void _onChangedFullName(
      OnChangedFullName event, Emitter<RegisterState> emit) {
    String fullName = state.fullName ?? "";
    fullName = event.val;
    emit(state.copyWith(fullName: fullName));
  }

  void _onChangedPassword(
      OnChangedPassword event, Emitter<RegisterState> emit) {
    String password = state.password ?? "";
    password = event.val;
    emit(state.copyWith(password: password));
  }

  void _onRegisterWithEmail(
      OnRegisterWithEmail event, Emitter<RegisterState> emit) async {
    String email = state.email ?? "";
    String password = state.password ?? "";
    try {
      await AuthFirebase.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await AuthFirebase.currUser?.updateDisplayName(state.fullName);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  void _onRegisterWithPhone(
      OnRegisterWithPhone event, Emitter<RegisterState> emit) async {
    String phone = state.phoneNumber ?? "";
    try {
      await AuthFirebase.verifyPhoneNumber(_nav.navKey.currentContext!, phone);
      await AuthFirebase.currUser?.updateDisplayName(state.fullName);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}
