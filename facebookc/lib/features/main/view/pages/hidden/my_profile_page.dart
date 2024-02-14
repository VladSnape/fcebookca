import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebookc/features/auth/domain/model/user_model.dart';
import 'package:facebookc/features/auth/view/bloc/cubit/get_user_cubit.dart';
import 'package:facebookc/features/auth/view/widgets/login_button.dart';
import 'package:facebookc/features/main/domain/models/post_model.dart';
import 'package:facebookc/features/main/view/pages/hidden/create_post_page.dart';
import 'package:facebookc/features/main/view/pages/hidden/edit_profile_page.dart';
import 'package:facebookc/features/main/view/pages/hidden/on_searching_page.dart';
import 'package:facebookc/features/main/view/pages/hidden/see_all_friends_page.dart';
import 'package:facebookc/features/main/view/widgets/mycontainer.dart';
import 'package:facebookc/features/main/view/widgets/post_widget.dart';
import 'package:facebookc/features/main/view/widgets/whats_on_your_mind.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyProfilePgae extends StatelessWidget {
  const MyProfilePgae({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OnSearchingPage(),
                    ));
              },
              icon: const Icon(
                Icons.search_rounded,
                size: 30,
              ))
        ],
        title: SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.5,
          height: 40,
          child: Center(
            child: BlocBuilder<GetUserCubit, GetUserState>(
              builder: (context, state) {
                if (state is GetUserSuccess) {
                  UserModel userModel = state.userModel;
                  return Text(
                    "${userModel.userName}",
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  );
                } else if (state is GetUserFailed) {
                  return Text(
                    "no User detected",
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  );
                } else if (state is GetUserInitial) {
                  return Text(
                    "initial state ",
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  );
                }
                return Text(
                  "user name",
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                );
              },
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
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
                      BlocBuilder<GetUserCubit, GetUserState>(
                        builder: (context, state) {
                          if (state is GetUserSuccess) {
                            return Container(
                              height: MediaQuery.sizeOf(context).height * 0.25,
                              color: Colors.black,
                              child: state.userModel.coverImage != null
                                  ? Image.network(
                                      state.userModel.coverImage!,
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              0.25,
                                      width: MediaQuery.sizeOf(context).width,
                                      fit: BoxFit.cover,
                                    )
                                  : null, // Set child to null if coverImage is null
                            );
                          } else {
                            return Container(
                              height: MediaQuery.sizeOf(context).height * 0.25,
                              color: Colors.black,
                            );
                          }
                        },
                      ),
                      Container(
                        height: MediaQuery.sizeOf(context).height * 0.05,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BlocBuilder<GetUserCubit, GetUserState>(
                    builder: (context, state) {
                      if (state is GetUserSuccess) {
                        return Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              width: 2.0,
                            ),
                          ),
                          child: CircleAvatar(
                            backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                            radius: MediaQuery.sizeOf(context).width * 0.2,
                            child: ClipOval(
                              child: state.userModel.avatarImage != null
                                  ? Image.network(
                                      state.userModel.avatarImage!,
                                      fit: BoxFit
                                          .cover, // Ensure the image covers the entire CircleAvatar
                                      width: MediaQuery.sizeOf(context).width *
                                          0.4, // Adjust width as needed
                                      height: MediaQuery.sizeOf(context).width *
                                          0.4, // Adjust height as needed
                                    )
                                  : null, // Set child to null if avatarImage is null
                            ),
                          ),
                        );
                      }
                      if (state is GetUserFailed) {
                        return Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Theme.of(context)
                                  .scaffoldBackgroundColor, // Set the color of the border
                              width: 2.0, // Set the width of the border
                            ),
                          ),
                        );
                      }
                      if (state is GetUserInitial) {
                        return Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Theme.of(context)
                                  .scaffoldBackgroundColor, // Set the color of the border
                              width: 2.0, // Set the width of the border
                            ),
                          ),
                        );
                      }
                      return CircleAvatar(
                        radius: MediaQuery.sizeOf(context).width * 0.2,
                      );
                    },
                  ),
                )
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
                      child: BlocBuilder<GetUserCubit, GetUserState>(
                        builder: (context, state) {
                          if (state is GetUserSuccess) {
                            UserModel userModel = state.userModel;
                            return Text(
                              "${userModel.name}",
                              style: Theme.of(context).textTheme.titleLarge,
                              textAlign: TextAlign.start,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            );
                          } else if (state is GetUserFailed) {
                            return Text(
                              "no User detected",
                              style: Theme.of(context).textTheme.titleLarge,
                              textAlign: TextAlign.start,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            );
                          } else if (state is GetUserInitial) {
                            return Text(
                              "initial state",
                              style: Theme.of(context).textTheme.titleLarge,
                              textAlign: TextAlign.start,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            );
                          }
                          return Text(
                            "user name",
                            style: Theme.of(context).textTheme.titleLarge,
                            textAlign: TextAlign.start,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          );
                        },
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CreatePostPage(),
                              ));
                        },
                        child: MyContainer(
                          text: 'add Post',
                          color: Colors.blue,
                          borderRadius: 10,
                          width: MediaQuery.sizeOf(context).width * 0.4,
                          isWhite: false,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const EditProfilePage(),
                              ));
                        },
                        child: MyContainer(
                          text: 'edit Profile',
                          color: Theme.of(context).secondaryHeaderColor,
                          borderRadius: 10,
                          width: MediaQuery.sizeOf(context).width * 0.4,
                          isWhite: false,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Divider(
                  color: Colors.grey,
                ),
              ),
            ),
            Container(
              height: MediaQuery.sizeOf(context).height * 0.5,
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
                              //       builder: (context) => ProfilePgae(),
                              //     ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MyContainer(
                                text: 'user name',
                                color: Theme.of(context).secondaryHeaderColor,
                                borderRadius: 10,
                                width: MediaQuery.sizeOf(context).width * 0.3,
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
                              builder: (context) => const SeeAllFriednsPage(),
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
            BlocBuilder<GetUserCubit, GetUserState>(
              builder: (context, state) {
                if (state is GetUserSuccess) {
                  return WhatsOnYourMindWidget(
                    avatar: state.userModel.avatarImage,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CreatePostPage(),
                          ));
                    },
                  );
                }
                return WhatsOnYourMindWidget(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CreatePostPage(),
                        ));
                  },
                );
              },
            ),
            BlocBuilder<GetUserCubit, GetUserState>(
              builder: (context, state) {
                if (state is GetUserSuccess) {
                  return StreamBuilder<QuerySnapshot>(
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
                                        builder: (context) =>
                                            const MyProfilePgae(),
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const MyProfilePgae(),
                                  ));
                            },
                          );
                        }
                      });
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return PostWidget(
                      postText: "cant load the post",
                      userName: "cant get user",
                      headerOnTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MyProfilePgae(),
                            ));
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
// newt is create posts  => add friedns => 