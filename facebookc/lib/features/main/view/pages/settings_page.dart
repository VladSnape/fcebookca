import 'package:facebookc/features/auth/view/bloc/cubit/get_user_cubit.dart';
import 'package:facebookc/features/auth/view/widgets/login_button.dart';
import 'package:facebookc/features/main/view/pages/hidden/my_profile_page.dart';
import 'package:facebookc/features/main/view/pages/hidden/on_searching_page.dart';
import 'package:facebookc/features/main/view/widgets/myicon_widget.dart';
import 'package:facebookc/features/settings/cubit/settings_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Menu",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OnSearchingPage(),
                        ));
                  },
                  child: const MyIconButton(
                    icon: Icons.search_outlined,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            buildProfileContainer(context),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Your shortcuts',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            yourShortcuts(),
            const SizedBox(
              height: 10,
            ),
            Text(
              'All shortcuts',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(
              height: 10,
            ),
            allShortcuts(),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              color: Color.fromARGB(114, 189, 189, 189),
            ),
            const SizedBox(
              height: 10,
            ),
            LogoutButton(
              onTap: () {
                BlocProvider.of<SettingsCubit>(context).toggleTheme();
              },
              text: 'switch theme ',
              isPrimary: false,
            ),
            const SizedBox(
              height: 3,
            ),
            const Divider(
              color: Color.fromARGB(114, 189, 189, 189),
            ),
            const SizedBox(
              height: 3,
            ),
            LogoutButton(
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
              text: 'Log out ',
              isPrimary: true,
            ),
          ],
        ),
      ),
    ));
  }

  SizedBox allShortcuts() {
    return SizedBox(
      height: 380,
      child: GridView.builder(
        itemCount: 5,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1.6,
            crossAxisCount: 2),
        itemBuilder: (context, index) {
          return Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(),
                    Text(
                      'groups',
                      style: Theme.of(context).textTheme.titleSmall,
                    )
                  ],
                ),
              ));
        },
      ),
    );
  }

  SizedBox yourShortcuts() {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => ProfilePgae(),
              //     ));
            },
            child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 30,
                    ),
                    SizedBox(
                      width: 70,
                      height: 40,
                      child: Center(
                        child: Text(
                          "user name",
                          style: Theme.of(context).textTheme.displaySmall,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                )),
          );
        },
      ),
    );
  }

  Material buildProfileContainer(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(8),
        height: 130,
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyProfilePgae(),
                    ));
              },
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.black,
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.7,
                    height: 40,
                    child: Center(
                      child: BlocBuilder<GetUserCubit, GetUserState>(
                        builder: (context, state) {
                          if (state is GetUserSuccess) {
                            return Text(
                              " ${state.userModel.userName} ",
                              style: Theme.of(context).textTheme.displayMedium,
                            );
                          } else if (state is GetUserInitial) {
                            return Text(
                              " itial state  ",
                              style: Theme.of(context).textTheme.displayMedium,
                            );
                          } else if (state is GetUserFailed) {
                            return Text(
                              " no user ( failed state ) ",
                              style: Theme.of(context).textTheme.displayMedium,
                            );
                          }
                          return Text(
                            " no i dea what state ",
                            style: Theme.of(context).textTheme.displayMedium,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            InkWell(
              onTap: () {},
              child: Row(
                children: [
                  const MyIconButton(
                    icon: Icons.add_rounded,
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.7,
                    height: 40,
                    child: Center(
                      child: Text(
                        " create another account ",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
