part of 'register_bloc.dart';

class RegisterState extends Equatable {
  final UserModel? user;
  final bool? isLoading;
  const RegisterState({this.user, this.isLoading});

  RegisterState copyWith({
    UserModel? user,
    bool? isloading,
  }) {
    return RegisterState(
      user: user ?? this.user,
      isLoading: isloading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [user, isLoading];
}
