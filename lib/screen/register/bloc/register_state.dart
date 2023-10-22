part of 'register_bloc.dart';

class RegisterState extends Equatable {
  final String? fullName;
  final String? phoneNumber;
  final String? email;
  final String? password;
  const RegisterState(
      {this.fullName, this.password, this.phoneNumber, this.email});

  RegisterState copyWith({
    String? email,
    String? password,
    String? fullName,
    String? phoneNumber,
  }) {
    return RegisterState(
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
    );
  }

  @override
  List<Object?> get props => [email, password, phoneNumber, fullName];
}
