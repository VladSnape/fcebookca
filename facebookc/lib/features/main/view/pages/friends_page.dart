import 'package:facebookc/features/auth/domain/model/user_model.dart';
import 'package:facebookc/features/auth/view/bloc/cubit/get_user_cubit.dart';
import 'package:facebookc/features/auth/view/widgets/login_button.dart';
import 'package:facebookc/features/main/view/widgets/confirm_delete_widget.dart';
import 'package:facebookc/features/main/view/widgets/mycontainer.dart';
import 'package:facebookc/features/main/view/widgets/myicon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FriendsPage extends StatelessWidget {
  const FriendsPage({super.key});

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
                  "Friends",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const MyIconButton(
                  icon: Icons.search_outlined,
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 45,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  MyContainer(
                    text: 'suggestions',
                    color: Theme.of(context).secondaryHeaderColor,
                    borderRadius: 20,
                    width: 140,
                    isWhite: false,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  MyContainer(
                    text: 'Your friends',
                    color: Theme.of(context).secondaryHeaderColor,
                    borderRadius: 20,
                    width: 140,
                    isWhite: false,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  MyContainer(
                    text: 'Close friends',
                    color: Theme.of(context).secondaryHeaderColor,
                    borderRadius: 20,
                    width: 140,
                    isWhite: false,
                  ),
                ],
              ),
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
            listHeader(context),
            BlocBuilder<GetUserCubit, GetUserState>(
              builder: (context, state) {
                if (state is GetUserSuccess) {
                  UserModel userModel = state.userModel;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: userModel.waitFriends?.length,
                    itemBuilder: (context, index) {
                      return ConfirmDeleteWidget(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => ProfilePgae(),
                          //     ));
                        },
                      );
                    },
                  );
                } else if (state is GetUserFailed) {
                  return const Center(
                    child: Text("cant load friends list"),
                  );
                } else if (state is GetUserInitial) {
                  return const Center(
                    child: Text("cant load friends list"),
                  );
                }
                return const Center(
                  child: Text("cant load friends list"),
                );
              },
            ),
            const SizedBox(
              height: 3,
            ),
            const LogoutButton(
              text: 'see all ',
              isPrimary: false,
            ),
            const SizedBox(
              height: 3,
            ),
          ],
        ),
      ),
    ));
  }

  Row listHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              ' Friends request',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            BlocBuilder<GetUserCubit, GetUserState>(
              builder: (context, state) {
                if (state is GetUserSuccess) {
                  return Text(
                    ' ${state.userModel.waitFriends?.length}',
                    textAlign: TextAlign.end,
                    style: Theme.of(context).textTheme.labelLarge,
                  );
                }
                return Text(
                  ' *',
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.labelLarge,
                );
              },
            ),
          ],
        ),
        TextButton(
            onPressed: () {},
            child: const Text(
              'See all',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w300,
                  color: Color.fromARGB(255, 0, 140, 255),
                  fontSize: 20),
            )),
      ],
    );
  }
}
