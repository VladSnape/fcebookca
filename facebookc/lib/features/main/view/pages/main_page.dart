// import 'package:facebookc/features/auth/domain/model/user_model.dart';
import 'package:facebookc/features/auth/view/bloc/cubit/get_user_cubit.dart';
import 'package:facebookc/features/main/view/pages/friends_page.dart';
import 'package:facebookc/features/main/view/pages/hidden/create_post_page.dart';
import 'package:facebookc/features/main/view/pages/hidden/on_searching_page.dart';
import 'package:facebookc/features/main/view/pages/home_page.dart';
import 'package:facebookc/features/main/view/pages/marketplace_page.dart';
import 'package:facebookc/features/main/view/pages/notification_page.dart';
import 'package:facebookc/features/main/view/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<GetUserCubit>();
    // final state = getUserCubit.state;
    // if (state is GetUserSuccess) {
    //   final UserModel userModel = state.userModel;
    // }
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          actions: [
            InkWell(
              child: const Icon(Icons.add_rounded),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreatePostPage(),
                    ));
              },
            ),
            const SizedBox(
              width: 10,
            ),
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OnSearchingPage(),
                      ));
                },
                child: const Icon(Icons.search_rounded)),
            const SizedBox(
              width: 10,
            ),
            const Icon(Bootstrap.messenger),
            const SizedBox(
              width: 8,
            ),
          ],
          title: const Text('facebook'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home_rounded)),
              Tab(icon: Icon(Icons.store_rounded)),
              Tab(icon: Icon(Icons.group_rounded)),
              Tab(icon: Icon(Icons.notifications_rounded)),
              Tab(icon: Icon(Icons.menu_rounded)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            HomePage(),
            MarketplacePage(),
            FriendsPage(),
            NotificationPage(),
            SettingsPage(),
          ],
        ),
      ),
    );
  }
}
