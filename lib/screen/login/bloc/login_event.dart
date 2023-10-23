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

class OnChangedLoginPhone extends LoginEvent {
  final String val;
  const OnChangedLoginPhone(this.val);
}

class OnLogin extends LoginEvent {
  const OnLogin();
}

class OnLoginPhoneNumber extends LoginEvent {
  final String val;
  const OnLoginPhoneNumber(this.val);
}

class OnLoginGoogle extends LoginEvent {
  const OnLoginGoogle();
}

class OnForgotPassword extends LoginEvent {
  final String val;
  const OnForgotPassword(this.val);
}
