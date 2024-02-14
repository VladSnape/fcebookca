// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:facebookc/features/auth/domain/model/user_model.dart';
import 'package:facebookc/features/auth/domain/usecases/getuser_usecase.dart';

part 'get_user_state.dart';

class GetUserCubit extends Cubit<GetUserState> {
  final GetUserUseCase getUserUseCase;
  GetUserCubit(this.getUserUseCase) : super(GetUserInitial()) {
    getuser();
  }

  getuser() async {
    final result = await getUserUseCase.call();
    result.fold((l) {
      emit(GetUserFailed(l.message));
    }, (r) {
      emit(GetUserSuccess(r));
    });
  }
}
