import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebookc/features/auth/data/impl/auth_impl.dart';
import 'package:facebookc/features/auth/data/source/remote_datasource.dart';
import 'package:facebookc/features/auth/domain/repo/auth_repo.dart';
import 'package:facebookc/features/auth/domain/usecases/getuser_usecase.dart';
import 'package:facebookc/features/auth/domain/usecases/login_user_usecase.dart';
import 'package:facebookc/features/auth/domain/usecases/register_user_usecase.dart';
import 'package:facebookc/features/auth/view/bloc/cubit/get_user_cubit.dart';
import 'package:facebookc/features/auth/view/bloc/loginCubit/cubit/login_cubit_cubit.dart';
import 'package:facebookc/features/main/data/impl/main_impl.dart';
import 'package:facebookc/features/main/data/source/remote/main_remote_datasource.dart';
import 'package:facebookc/features/main/domain/repo/main_repo.dart';
import 'package:facebookc/features/main/domain/usecases/friend/addfirend_usecase.dart';
import 'package:facebookc/features/main/domain/usecases/friend/cancelfriend_usecase.dart';
import 'package:facebookc/features/main/domain/usecases/posts/add_comment_usecase.dart';
import 'package:facebookc/features/main/domain/usecases/posts/add_like_usecase.dart';
import 'package:facebookc/features/main/domain/usecases/posts/add_post_usecase.dart';
import 'package:facebookc/features/main/domain/usecases/posts/read_post_usecase.dart';
import 'package:facebookc/features/main/domain/usecases/profile/edit_profile_usecase.dart';
import 'package:facebookc/features/main/domain/usecases/profile/getUserInfo.dart';
import 'package:facebookc/features/main/view/bloc/friend/cubit/add_cancel_friend_cubit.dart';
import 'package:facebookc/features/main/view/bloc/post/cubit/add_like_comment_cubit.dart';
import 'package:facebookc/features/main/view/bloc/post/cubit/add_post_cubit.dart';
import 'package:facebookc/features/main/view/bloc/post/cubit/read_post_cubit.dart';
import 'package:facebookc/features/main/view/bloc/profile/cubit/edit_profile_cubit.dart';
import 'package:facebookc/features/main/view/bloc/profile/cubit/get_user_info_cubit.dart';
import 'package:facebookc/features/settings/cubit/settings_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;
void init() {
// bloc
  sl.registerFactory(() => LoginCubitCubit(
        loginUserUseCase: sl(),
        registerUserUseCase: sl(),
      ));
  sl.registerFactory(() => SettingsCubit());
  sl.registerFactory(() => EditProfileCubit(sl()));
  sl.registerFactory(() => AddPostCubit(sl()));
  sl.registerFactory(() => ReadPostCubit(sl()));
  sl.registerFactory(() => GetUserInfoCubit(sl()));

  sl.registerFactory(() => AddLikeCommentCubit(sl(), sl()));
  sl.registerLazySingleton(() => AddCancelFriendCubit(sl(), sl()));

  sl.registerFactory(() => GetUserCubit(sl()));
//use cases
  sl.registerLazySingleton(() => GetUserUseCase(sl()));

  sl.registerLazySingleton(() => LoginUserUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUserUseCase(sl()));
  sl.registerLazySingleton(() => EditProfileUseCase(sl()));
  sl.registerLazySingleton(() => AddPostUseCase(sl()));
  sl.registerLazySingleton(() => ReadPostUseCase(sl()));

  sl.registerLazySingleton(() => AddCommentUseCase(sl()));
  sl.registerLazySingleton(() => AddLikeUseCase(sl()));
  sl.registerLazySingleton(() => GetUserInfoUseCase(sl()));
  sl.registerLazySingleton(() => AddFriendUseCase(sl()));
  sl.registerLazySingleton(() => CancelAddFriendUseCase(sl()));

// repo impl
  sl.registerLazySingleton<AuthRepo>(() => AuthImpl(sl()));
  sl.registerLazySingleton<MainRepo>(() => MainImpl(sl()));
// data dource impl
  sl.registerLazySingleton<AuthRemoteDatasource>(
      () => AuthImplWithFirebase(firebaseAuth: sl(), firestore: sl()));
  sl.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceIWFirebase(sl(), sl()));

// other : firebase - firestore
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
}
