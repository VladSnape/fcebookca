import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:facebookc/features/main/domain/models/post_model.dart';
import 'package:facebookc/features/main/domain/usecases/posts/add_post_usecase.dart';

part 'add_post_state.dart';

class AddPostCubit extends Cubit<AddPostState> {
  final AddPostUseCase addPostUseCase;
  AddPostCubit(this.addPostUseCase) : super(AddPostInitial());
  addPost(PostModel postModel) async {
    final result = await addPostUseCase.call(postModel: postModel);
    result.fold((l) {
      emit(AddPostFailed(l.message));
    }, (r) {
      emit(AddPostSuccess());
    });
  }
}
