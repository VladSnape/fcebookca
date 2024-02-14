import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:facebookc/features/auth/domain/model/user_model.dart';
import 'package:facebookc/features/main/domain/usecases/profile/getUserInfo.dart';

part 'get_user_info_state.dart';

class GetUserInfoCubit extends Cubit<GetUserInfoState> {
  final GetUserInfoUseCase getUserInfoUseCase;
  GetUserInfoCubit(this.getUserInfoUseCase) : super(GetUserInfoInitial());

  getUserInfo({required String userId}) async {
    emit(GetUserInfoLoading());
    try {
      final result = await getUserInfoUseCase.call(userId: userId);
      result.fold((l) {
        emit(GetUserInfoFailed(l.message));
      }, (r) {
        emit(GetUserInfoSuccess(r));
        print('get user info success here is the user $r');
      });
    } catch (e) {
      emit(GetUserInfoFailed("failed to try here is why $e"));
    }
  }
}
