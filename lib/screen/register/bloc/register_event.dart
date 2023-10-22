part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class OnChangedEmail extends RegisterEvent {
  final String val;
  const OnChangedEmail(this.val);
}

class OnChangedPhone extends RegisterEvent {
  final String val;
  const OnChangedPhone(this.val);
}

class OnChangedFullName extends RegisterEvent {
  final String val;
  const OnChangedFullName(this.val);
}

class OnChangedPassword extends RegisterEvent {
  final String val;
  const OnChangedPassword(this.val);
}

class OnRegisterWithEmail extends RegisterEvent {
  const OnRegisterWithEmail();
}

class OnRegisterWithPhone extends RegisterEvent {
  const OnRegisterWithPhone();
}
