import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/screen/login/auth.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<OnChangedEmailOrPhone>(_onChangedEmailOrPhone);
    on<OnChangedPassword>(_onChangedPassword);
    on<OnLogin>(_onLogin);
    on<OnRegister>(_onRegister);
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
      var data = await Auth.signInWithEmailAndPassword(
        email: emailOrPassword,
        password: password,
      );
      print(data);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  void _onRegister(OnRegister event, Emitter<LoginState> emit) async {
    String emailOrPassword = state.emailOrPhone ?? "";
    String password = state.password ?? "";
    try {
      var data = await Auth.createUserWithEmailAndPassword(
        email: emailOrPassword,
        password: password,
      );
      print(data);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}
