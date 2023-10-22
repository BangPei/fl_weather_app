part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class OnChangedPassword extends LoginEvent {
  final String val;
  const OnChangedPassword(this.val);
}

class OnChangedEmailOrPhone extends LoginEvent {
  final String val;
  const OnChangedEmailOrPhone(this.val);
}

class OnLogin extends LoginEvent {
  const OnLogin();
}

class OnRegister extends LoginEvent {
  const OnRegister();
}
