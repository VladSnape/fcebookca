import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:facebookc/features/main/domain/models/post_model.dart';
import 'package:facebookc/features/main/domain/usecases/posts/read_post_usecase.dart';

part 'read_post_state.dart';

class ReadPostCubit extends Cubit<ReadPostState> {
  final ReadPostUseCase readPostUseCase;
  ReadPostCubit(this.readPostUseCase) : super(ReadPostInitial());
  readPost({required String postId}) async {
    try {
      final result = await readPostUseCase.call(postId: postId);
      result.fold((l) {
        emit(ReadPostFailed(l.message));
      }, (r) {
        emit(ReadPostSuccess(r));
      });
    } catch (e) {}
  }
}
