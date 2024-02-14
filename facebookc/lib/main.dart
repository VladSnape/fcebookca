import 'package:facebookc/features/auth/view/bloc/cubit/get_user_cubit.dart';
import 'package:facebookc/features/auth/view/bloc/loginCubit/cubit/login_cubit_cubit.dart';
import 'package:facebookc/features/auth/view/pages/auth_state.dart';
import 'package:facebookc/features/main/view/bloc/friend/cubit/add_cancel_friend_cubit.dart';
import 'package:facebookc/features/main/view/bloc/post/cubit/add_like_comment_cubit.dart';
import 'package:facebookc/features/main/view/bloc/post/cubit/add_post_cubit.dart';
import 'package:facebookc/features/main/view/bloc/post/cubit/read_post_cubit.dart';
import 'package:facebookc/features/main/view/bloc/profile/cubit/edit_profile_cubit.dart';
import 'package:facebookc/features/main/view/bloc/profile/cubit/get_user_info_cubit.dart';

import 'package:facebookc/features/settings/cubit/settings_cubit.dart';
import 'package:facebookc/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubitCubit>(create: (_) => sl<LoginCubitCubit>()),
        BlocProvider<GetUserCubit>(create: (_) => sl<GetUserCubit>()),
        BlocProvider<SettingsCubit>(create: (_) => sl<SettingsCubit>()),
        BlocProvider<EditProfileCubit>(create: (_) => sl<EditProfileCubit>()),
        BlocProvider<ReadPostCubit>(create: (_) => sl<ReadPostCubit>()),
        BlocProvider<AddPostCubit>(create: (_) => sl<AddPostCubit>()),
        BlocProvider<GetUserInfoCubit>(create: (_) => sl<GetUserInfoCubit>()),
        BlocProvider<AddCancelFriendCubit>(
            create: (_) => sl<AddCancelFriendCubit>()),
        BlocProvider<AddLikeCommentCubit>(
            create: (_) => sl<AddLikeCommentCubit>()),
      ],
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return MaterialApp(
            theme: state.themeData,
            home: AuthStatePage(),
          );
        },
      ),
    );
  }
}
