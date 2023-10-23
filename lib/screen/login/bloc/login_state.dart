part of 'login_bloc.dart';

class LoginState extends Equatable {
  final bool? isLoading;
  final String? password;
  final String? email;
  final String? phoneNumber;
  const LoginState(
      {this.phoneNumber, this.isLoading, this.password, this.email});

  LoginState copyWith(
      {bool? isLoading, String? password, String? email, String? phoneNumber}) {
    return LoginState(
      email: email ?? this.email,
      isLoading: isLoading ?? this.isLoading,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  @override
  List<Object?> get props => [isLoading, email, password, phoneNumber];
}
