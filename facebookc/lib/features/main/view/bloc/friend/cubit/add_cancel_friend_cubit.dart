import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:facebookc/features/auth/domain/model/user_model.dart';
import 'package:facebookc/features/main/domain/usecases/friend/addfirend_usecase.dart';
import 'package:facebookc/features/main/domain/usecases/friend/cancelfriend_usecase.dart';

part 'add_cancel_friend_state.dart';

class AddCancelFriendCubit extends Cubit<AddCancelFriendState> {
  final AddFriendUseCase addFriendUseCase;
  final CancelAddFriendUseCase cancelAddFriendUseCase;
  AddCancelFriendCubit(this.addFriendUseCase, this.cancelAddFriendUseCase)
      : super(AddCancelFriendNotFried());

  putAddCancelFriendNotFriedState() {
    emit(AddCancelFriendNotFried());
  }

  clickToAdd({
    required UserModel you,
    required String hisId,
  }) async {
    try {
      emit(AddCancelFriendLoading());
      final result = await addFriendUseCase.call(you: you, hisId: hisId);
      result.fold((l) {
        emit(AddCancelFriendFailed(l.message));
      }, (r) {
        emit(AddCancelFriendWaitingToAcceptMe());
      });
    } catch (e) {
      emit(AddCancelFriendFailed(e.toString()));
    }
  }

  putAddCancelFriendWaitingToAcceptMe() {
    emit(AddCancelFriendWaitingToAcceptMe());
  }

  clickButton({
    required UserModel you,
    required String hisId,
  }) async {
    if (state is AddCancelFriendNotFried) {
      try {
        emit(AddCancelFriendLoading());
        final result = await addFriendUseCase.call(you: you, hisId: hisId);
        result.fold((l) {
          emit(AddCancelFriendFailed(l.message));
        }, (r) {
          emit(AddCancelFriendWaitingToAcceptMe());
        });
      } catch (e) {
        emit(AddCancelFriendFailed(e.toString()));
      }
    } else if (state is AddCancelFriendWaitingToAcceptMe) {
      try {
        emit(AddCancelFriendLoading());
        final result =
            await cancelAddFriendUseCase.call(you: you, hisId: hisId);
        result.fold((l) {
          emit(AddCancelFriendFailed(l.message));
        }, (r) {
          emit(AddCancelFriendWaitingToAcceptMe());
        });
      } catch (e) {
        emit(AddCancelFriendFailed(e.toString()));
      }
    }
  }
}
