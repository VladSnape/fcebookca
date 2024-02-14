import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:facebookc/features/auth/domain/usecases/login_user_usecase.dart';
import 'package:facebookc/features/auth/domain/usecases/register_user_usecase.dart';

part 'login_cubit_state.dart';

class LoginCubitCubit extends Cubit<LoginCubitState> {
  final LoginUserUseCase loginUserUseCase;
  final RegisterUserUseCase registerUserUseCase;

  LoginCubitCubit({
    required this.loginUserUseCase,
    required this.registerUserUseCase,
  }) : super(const LoginCubitInitial('inital'));

  void loginUser({required String email, required String password}) async {
    final result =
        await loginUserUseCase.call(email: email, password: password);
    result.fold((l) {
      emit(const LoginCubitInitial('success'));
    }, (r) {
      emit(const LoginCubitInitial('failed '));
    });
  }

  Future registreUser(
      {required String email,
      required String password,
      String? name,
      String? userName}) async {
    final result = await registerUserUseCase.call(
        email: email, password: password, name: name, userName: userName);
    result.fold((l) {
      emit(const LoginCubitInitial('success'));
    }, (r) {
      emit(const LoginCubitInitial('failed '));
    });
  }
}
