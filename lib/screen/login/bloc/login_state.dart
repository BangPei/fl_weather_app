part of 'login_bloc.dart';

class LoginState extends Equatable {
  final bool? isLoading;
  final String? password;
  final String? emailOrPhone;
  const LoginState({this.isLoading, this.password, this.emailOrPhone});

  LoginState copyWith(
      {bool? isLoading, String? password, String? emailOrPhone}) {
    return LoginState(
      emailOrPhone: emailOrPhone ?? this.emailOrPhone,
      isLoading: isLoading ?? this.isLoading,
      password: password ?? this.password,
    );
  }

  @override
  List<Object?> get props => [isLoading, emailOrPhone, password];
}
