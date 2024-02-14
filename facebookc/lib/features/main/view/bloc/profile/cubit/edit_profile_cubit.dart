import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:facebookc/features/main/domain/usecases/profile/edit_profile_usecase.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final EditProfileUseCase editProfileUseCase;
  EditProfileCubit(this.editProfileUseCase) : super(EditProfileInitial());
  editProfile({
    required String id,
    String? name,
    String? bio,
    String? userName,
    String? photoUrl,
    String? coverUrl,
  }) async {
    final result = await editProfileUseCase.call(
        id: id,
        userName: userName,
        name: name,
        photoUrl: photoUrl,
        coverUrl: coverUrl,
        bio: bio);
    result.fold((l) {
      emit(EditProfileFailure(l.message));
    }, (r) {
      emit(EditProfileSuccess());
    });
  }
}
