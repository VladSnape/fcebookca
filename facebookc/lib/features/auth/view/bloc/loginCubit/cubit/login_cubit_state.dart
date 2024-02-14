part of 'login_cubit_cubit.dart';

sealed class LoginCubitState extends Equatable {
  const LoginCubitState();

  @override
  List<Object> get props => [];
}

final class LoginCubitInitial extends LoginCubitState {
  final String message;

  const LoginCubitInitial(this.message);
}
