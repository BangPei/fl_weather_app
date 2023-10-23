part of 'register_bloc.dart';

class RegisterState extends Equatable {
  final bool? isLoading;
  final UserModel? user;
  const RegisterState({this.user, this.isLoading});

  RegisterState copyWith({
    UserModel? user,
    bool? isloading,
  }) {
    return RegisterState(
      user: user ?? this.user,
      isLoading: isloading ?? true,
    );
  }

  @override
  List<Object?> get props => [user, isLoading];
}
