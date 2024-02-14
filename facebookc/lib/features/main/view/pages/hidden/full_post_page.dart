import 'package:facebookc/features/auth/view/bloc/cubit/get_user_cubit.dart';
import 'package:facebookc/features/main/domain/models/comment_model.dart';
import 'package:facebookc/features/main/domain/models/like_model.dart';
import 'package:facebookc/features/main/domain/models/post_model.dart';
import 'package:facebookc/features/main/view/bloc/post/cubit/add_like_comment_cubit.dart';
import 'package:facebookc/features/main/view/bloc/post/cubit/read_post_cubit.dart';
import 'package:facebookc/features/main/view/pages/hidden/on_searching_page.dart';
import 'package:facebookc/features/main/view/pages/hidden/profile_page.dart';
import 'package:facebookc/features/main/view/widgets/comment_text_field.dart';
import 'package:facebookc/features/main/view/widgets/comment_widet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FullPostPage extends StatefulWidget {
  const FullPostPage({
    Key? key,
  }) : super(key: key);

  @override
  State<FullPostPage> createState() => _FullPostPageState();
}

class _FullPostPageState extends State<FullPostPage> {
  TextEditingController commentController = TextEditingController();
  FocusNode commentFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
              icon: const Icon(Icons.search_rounded))
        ],
        title: Text(
          "Post",
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
      body: BlocBuilder<ReadPostCubit, ReadPostState>(
        builder: (context, state) {
          if (state is ReadPostSuccess) {
            PostModel postModel = state.postModel;
            return BlocListener<AddLikeCommentCubit, AddLikeCommentState>(
              listener: (context, state) {
                if (state is AddLikeCommentsuccess) {
                  print('AddLikeCommentsuccess state detected');
                  BlocProvider.of<ReadPostCubit>(context)
                      .readPost(postId: postModel.id);
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProfilePgae(
                                          userId: state.postModel.author,
                                        ),
                                      ));
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          width: 2.0,
                                        ),
                                      ),
                                      child: CircleAvatar(
                                        backgroundColor:
                                            const Color.fromARGB(255, 0, 0, 0),
                                        radius: 20,
                                        child: ClipOval(
                                          child: postModel.authorAvatar != null
                                              ? Image.network(
                                                  postModel.authorAvatar!,
                                                  fit: BoxFit
                                                      .cover, // Ensure the image covers the entire CircleAvatar
                                                  width:
                                                      40, // Adjust width as needed
                                                  height:
                                                      40, // Adjust height as needed
                                                )
                                              : null, // Set child to null if avatarImage is null
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      child: Text(
                                        "${postModel.authorUserName}",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                "${postModel.text} ",
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                maxLines: 30,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.transparent,
                              ),
                              width: MediaQuery.sizeOf(context).width,
                              // height: 200,
                              child: postModel.image != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        postModel.image!,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : const Text(''),
                            ),
                            const Divider(
                              color: Colors.black,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        BlocProvider.of<AddLikeCommentCubit>(
                                                context)
                                            .addLike(
                                                likeModel: LikeModel(
                                                    liketype: Liketype.jaime,
                                                    authorId: FirebaseAuth
                                                        .instance
                                                        .currentUser!
                                                        .uid),
                                                postId: postModel.id);
                                      },
                                      icon: const Icon(
                                        Icons.favorite_border_rounded,
                                      ),
                                    ),
                                    Text(
                                      "${postModel.likes?.length ?? 0}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          commentFocusNode.requestFocus();
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.chat_bubble_rounded,
                                      ),
                                    ),
                                    Text(
                                      "${postModel.comments?.length ?? 0}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        commentController.clear();
                                      },
                                      icon: const Icon(
                                        Icons.send_rounded,
                                      ),
                                    ),
                                    Text(
                                      "Send",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    )
                                  ],
                                ),
                              ],
                            ),
                            const Divider(
                              color: Colors.black,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Comment :",
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ],
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: postModel.comments?.length ?? 1,
                              itemBuilder: (context, index) {
                                if (postModel.comments != null) {
                                  return CommentWidget(
                                    userId: postModel.comments![index].userId,
                                    userName: postModel
                                        .comments![index].authorUserName,
                                    avatar: postModel.comments![index].avatar,
                                    commentText:
                                        postModel.comments![index].text,
                                  );
                                } else {
                                  return const Center(
                                    child: Text("no comments yet"),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CommentTextField(
                            onSubmitted: (p0) {
                              commentFocusNode.unfocus();
                              commentController.clear();
                            },
                            focusNode: commentFocusNode,
                            controller: commentController,
                            text: "Write a comment",
                          ),
                        ),
                        BlocBuilder<GetUserCubit, GetUserState>(
                          builder: (context, state) {
                            if (state is GetUserSuccess) {
                              return IconButton(
                                onPressed: () {
                                  setState(() {
                                    BlocProvider.of<AddLikeCommentCubit>(
                                            context)
                                        .addComment(
                                            commentModel: CommentModel(
                                                avatar:
                                                    state.userModel.avatarImage,
                                                text: commentController.text,
                                                authorUserName:
                                                    state.userModel.userName!,
                                                userId: state.userModel.id),
                                            postId: postModel.id);
                                    commentFocusNode.unfocus();
                                    commentController.clear();
                                  });
                                },
                                icon: const Icon(
                                  Icons.send,
                                  color: Colors.blue,
                                ),
                              );
                            }
                            return IconButton(
                              onPressed: () {
                                setState(() {
                                  commentFocusNode.unfocus();
                                  commentController.clear();
                                });
                              },
                              icon: const Icon(
                                Icons.send,
                                color: Color.fromARGB(255, 203, 232, 255),
                              ),
                            );
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          } else if (state is ReadPostFailed) {
            return const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(" failed to load post"));
          } else if (state is ReadPostLoading) {
            const Center(
              child: CircularProgressIndicator(),
            );
          }
          return const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(" cant get the state of the post"));
        },
      ),
    );
  }
}
