// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:facebookc/features/main/domain/models/like_model.dart';
import 'package:facebookc/features/main/view/bloc/post/cubit/add_like_comment_cubit.dart';
import 'package:facebookc/features/main/view/bloc/post/cubit/read_post_cubit.dart';
import 'package:facebookc/features/main/view/pages/hidden/full_post_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class PostWidget extends StatelessWidget {
  final String? userName;
  final String? avatar;
  final int? likes;
  final int? comments;
  final String? postId;

  final String postText;
  final String? image;
  final void Function()? headerOnTap;
  const PostWidget({
    Key? key,
    this.headerOnTap,
    this.userName,
    this.avatar,
    required this.postText,
    this.image,
    this.likes,
    this.comments,
    this.postId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 2.5,
      ),
      child: Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          children: [
            InkWell(
              onTap: headerOnTap,
              child: Container(
                // header container
                height: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                width: 2.0,
                              ),
                            ),
                            child: CircleAvatar(
                              backgroundColor:
                                  const Color.fromARGB(255, 0, 0, 0),
                              radius: 20,
                              child: ClipOval(
                                child: avatar != null
                                    ? Image.network(
                                        avatar!,
                                        fit: BoxFit
                                            .cover, // Ensure the image covers the entire CircleAvatar
                                        width: 40, // Adjust width as needed
                                        height: 40, // Adjust height as needed
                                      )
                                    : null, // Set child to null if avatarImage is null
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.4,
                            child: Text(
                              userName ?? 'user Not found',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.more_horiz_rounded,
                              )),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.close_rounded,
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                if (postId != null) {
                  BlocProvider.of<ReadPostCubit>(context)
                      .readPost(postId: postId!);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FullPostPage(),
                      ));
                }
              },
              child: Container(
                // hasimage?  postimage : textPost;
                // height: 300,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: Column(
                  children: [
                    Center(child: Text(postText)),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.transparent,
                      ),
                      width: MediaQuery.sizeOf(context).width,
                      // height: 200,
                      child: image != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                image!,
                                fit: BoxFit.cover,
                              ),
                            )
                          : const Text(''),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(
                thickness: 2,
                height: 2,
              ),
            ),
            Container(
              // comment like share container
              height: 50,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              if (postId != null) {
                                BlocProvider.of<AddLikeCommentCubit>(context)
                                    .addLike(
                                        likeModel: LikeModel(
                                            liketype: Liketype.jaime,
                                            authorId: FirebaseAuth
                                                .instance.currentUser!.uid),
                                        postId: postId!);
                              }
                            },
                            icon: const Icon(
                              Icons.favorite_border_rounded,
                            )),
                        Text("${likes ?? 0}")
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) {
                                  return DraggableScrollableSheet(
                                    initialChildSize: 0.9, // Adjust as needed
                                    minChildSize: 0.9, // Adjust as needed
                                    maxChildSize: 1.0, // Adjust as needed
                                    expand: true,
                                    builder: (context, scrollController) {
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        controller: scrollController,
                                        itemCount: 10,
                                        itemBuilder: (context, index) {
                                          return Container();
                                          // return CommentWidget();
                                        },
                                      );
                                    },
                                  );
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.chat_bubble_rounded,
                            )),
                        Text("${comments ?? 0}")
                      ],
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.reply_rounded,
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
