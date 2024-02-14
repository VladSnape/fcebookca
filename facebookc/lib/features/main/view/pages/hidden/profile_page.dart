import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebookc/features/auth/domain/model/user_model.dart';
import 'package:facebookc/features/auth/view/bloc/cubit/get_user_cubit.dart';
import 'package:facebookc/features/auth/view/widgets/login_button.dart';
import 'package:facebookc/features/main/data/source/remote/main_remote_datasource.dart';
import 'package:facebookc/features/main/domain/models/post_model.dart';
import 'package:facebookc/features/main/view/bloc/friend/cubit/add_cancel_friend_cubit.dart';
import 'package:facebookc/features/main/view/bloc/profile/cubit/get_user_info_cubit.dart';
import 'package:facebookc/features/main/view/pages/hidden/see_all_friends_page.dart';
import 'package:facebookc/features/main/view/widgets/mycontainer.dart';
import 'package:facebookc/features/main/view/widgets/post_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePgae extends StatefulWidget {
  final String userId;

  const ProfilePgae({super.key, required this.userId});

  @override
  State<ProfilePgae> createState() => _ProfilePgaeState();
}

class _ProfilePgaeState extends State<ProfilePgae> {
  UserModel? thisUserModel;
  UserModel? youUserModel;
  @override
  void initState() {
    fetchOtherUserInfo();
    fetchYouUserInfo();

    super.initState();
  }

  Future<void> fetchOtherUserInfo() async {
    try {
      final userState = await BlocProvider.of<GetUserInfoCubit>(context)
          .getUserInfo(userId: widget.userId);

      if (userState is GetUserInfoSuccess) {
        setState(() {
          thisUserModel = userState.userModel;
        });
      }
      // ignore: empty_catches
    } catch (e) {}
  }

  Future<void> fetchYouUserInfo() async {
    try {
      final userState = await BlocProvider.of<GetUserCubit>(context).getuser();

      if (userState is GetUserSuccess) {
        setState(() {
          youUserModel = userState.userModel;
        });
      }
      // ignore: empty_catches
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextButton(
          onPressed: () {},
          child: Row(
            children: [
              const Icon(
                Icons.search_rounded,
              ),
              Text(
                "search",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
      body: BlocBuilder<GetUserInfoCubit, GetUserInfoState>(
        builder: (context, state) {
          if (state is GetUserInfoSuccess) {
            final UserModel userModel = state.userModel;
            if (userModel.waitFriends != null) {
              if (userModel.waitFriends!.contains(
                  FriendModel(id: FirebaseAuth.instance.currentUser!.uid))) {
                BlocProvider.of<AddCancelFriendCubit>(context)
                    .putAddCancelFriendWaitingToAcceptMe();
              } else {
                BlocProvider.of<AddCancelFriendCubit>(context)
                    .putAddCancelFriendNotFriedState();
              }
            } else {}
            return SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Container(
                        height: MediaQuery.sizeOf(context).height * 0.3,
                        color: Theme.of(context).secondaryHeaderColor,
                        width: MediaQuery.sizeOf(context).width,
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black,
                              ),
                              width: MediaQuery.sizeOf(context).width,
                              height: MediaQuery.sizeOf(context).height * 0.25,
                              child: userModel.coverImage != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        userModel.coverImage!,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : const Text('no image'),
                            ),
                            Container(
                              height: MediaQuery.sizeOf(context).height * 0.05,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            width: 2.0,
                          ),
                        ),
                        child: CircleAvatar(
                          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                          radius: 75,
                          child: ClipOval(
                            child: userModel.avatarImage != null
                                ? Image.network(
                                    userModel.avatarImage!,
                                    fit: BoxFit
                                        .cover, // Ensure the image covers the entire CircleAvatar
                                    width: 150, // Adjust width as needed
                                    height: 150, // Adjust height as needed
                                  )
                                : null, // Set child to null if avatarImage is null
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: MediaQuery.sizeOf(context).height * 0.15,
                    width: MediaQuery.sizeOf(context).width,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: MediaQuery.sizeOf(context).width,
                            height: 40,
                            child: Text(
                              userModel.userName ?? '',
                              style: Theme.of(context).textTheme.titleLarge,
                              textAlign: TextAlign.start,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            BlocBuilder<AddCancelFriendCubit,
                                AddCancelFriendState>(
                              builder: (context, state) {
                                if (state is AddCancelFriendNotFried) {
                                  return InkWell(
                                    onTap: () {
                                      fetchYouUserInfo();
                                      BlocProvider.of<AddCancelFriendCubit>(
                                              context)
                                          .clickToAdd(
                                              you: UserModel(
                                                  id: youUserModel?.id,
                                                  avatarImage:
                                                      youUserModel?.avatarImage,
                                                  userName:
                                                      youUserModel?.userName),
                                              hisId: widget.userId);
                                    },
                                    child: MyContainer(
                                      text: 'add Friend',
                                      color: Colors.blue,
                                      borderRadius: 10,
                                      width: MediaQuery.sizeOf(context).width *
                                          0.4,
                                      isWhite: false,
                                    ),
                                  );
                                }
                                return InkWell(
                                  onTap: () {},
                                  child: MyContainer(
                                    text: 'add Friend',
                                    color: Colors.blue,
                                    borderRadius: 10,
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.4,
                                    isWhite: false,
                                  ),
                                );
                              },
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            MyContainer(
                              text: 'Message',
                              color: Theme.of(context).secondaryHeaderColor,
                              borderRadius: 10,
                              width: MediaQuery.sizeOf(context).width * 0.4,
                              isWhite: false,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // height: MediaQuery.sizeOf(context).height * 0.5,
                    width: MediaQuery.sizeOf(context).width,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width,
                            height: 40,
                            child: Text(
                              "Friends : ",
                              style: Theme.of(context).textTheme.displayMedium,
                              textAlign: TextAlign.start,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.sizeOf(context).width * 0.7,
                            child: GridView.builder(
                              itemCount: 6,
                              scrollDirection: Axis.horizontal,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //       builder: (context) =>  ProfilePgae(userId: userModel.friends.,),
                                    //     ));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: MyContainer(
                                      text: 'friend',
                                      color: Theme.of(context)
                                          .secondaryHeaderColor,
                                      borderRadius: 10,
                                      width: MediaQuery.sizeOf(context).width *
                                          0.3,
                                      isWhite: false,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          LogoutButton(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const SeeAllFriednsPage(),
                                  ));
                            },
                            text: 'see all friends ',
                            isPrimary: false,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      height: 30,
                      child: Text(
                        "posts : ",
                        style: Theme.of(context).textTheme.displayMedium,
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("posts")
                          .where('author', isEqualTo: state.userModel.id)
                          .orderBy('timeStamp', descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<DocumentSnapshot> postDocs = snapshot.data!.docs;

                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: postDocs.length,
                            itemBuilder: (context, index) {
                              Map<String, dynamic> postSnapshot =
                                  postDocs[index].data()
                                      as Map<String, dynamic>;
                              PostModel post = PostModel.fromMap(postSnapshot);

                              return PostWidget(
                                comments: post.comments?.length,
                                likes: post.likes?.length,
                                postId: post.id,
                                image: post.image,
                                postText: post.text,
                                userName: state.userModel.userName!,
                                avatar: state.userModel.avatarImage,
                                headerOnTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProfilePgae(
                                          userId: post.author,
                                        ),
                                      ));
                                },
                              );
                            },
                          );
                        } else {
                          return PostWidget(
                            postText: "cant load the post",
                            userName: state.userModel.userName!,
                            avatar: state.userModel.avatarImage,
                            headerOnTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => ProfilePgae(userId:,),
                              //     ));
                            },
                          );
                        }
                      }),
                ],
              ),
            );
          } else if (state is GetUserInfoLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetUserInfoFailed) {
            return const Center(
              child: Text("user not found "),
            );
          } else if (state is GetUserInfoInitial) {
            return const Center(
              child: Text("initial state restart the app"),
            );
          }
          return const Center(
            child: Text(" no idea what state you in , restart later"),
          );
        },
      ),
    );
  }
}
