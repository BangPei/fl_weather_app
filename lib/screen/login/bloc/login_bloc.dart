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
  }

  void _onChangedEmailOrPhone(
      OnChangedEmailOrPhone event, Emitter<LoginState> emit) {
    String emailOrPhone = state.emailOrPhone ?? "";
    emailOrPhone = event.val;
    emit(state.copyWith(emailOrPhone: emailOrPhone));
  }

  void _onChangedPassword(OnChangedPassword event, Emitter<LoginState> emit) {
    String password = state.password ?? "";
    password = event.val;
    emit(state.copyWith(password: password));
  }

  void _onLogin(OnLogin event, Emitter<LoginState> emit) async {
    String emailOrPassword = state.emailOrPhone ?? "";
    String password = state.password ?? "";
    try {
      await AuthFirebase.signInWithEmailAndPassword(
        email: emailOrPassword,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  void _onLoginPhoneNumber(
      OnLoginPhoneNumber event, Emitter<LoginState> emit) async {
    try {
      // await AuthFirebase.signInWithPhoneNumber(
      //     phoneNumber: state.emailOrPhone!);
      await AuthFirebase.verifyPhoneNumber(
          _nav.navKey.currentContext!, state.emailOrPhone!);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}
