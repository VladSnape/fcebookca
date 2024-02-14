import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebookc/features/main/domain/models/post_model.dart';
import 'package:facebookc/features/main/view/pages/hidden/create_post_page.dart';
import 'package:facebookc/features/main/view/pages/hidden/my_profile_page.dart';
import 'package:facebookc/features/main/view/pages/hidden/profile_page.dart';
import 'package:facebookc/features/main/view/widgets/post_widget.dart';
import 'package:facebookc/features/main/view/widgets/whats_on_your_mind.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            WhatsOnYourMindWidget(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreatePostPage(),
                    ));
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1.5,
                    crossAxisCount: 1,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 7,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 153, 153, 153),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection("posts").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<DocumentSnapshot> postDocs = snapshot.data!.docs;

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: postDocs.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> postSnapshot =
                          postDocs[index].data() as Map<String, dynamic>;
                      PostModel post = PostModel.fromMap(postSnapshot);

                      return InkWell(
                        child: PostWidget(
                          postId: post.id,
                          likes: post.likes?.length,
                          comments: post.comments?.length,
                          image: post.image,
                          postText: post.text,
                          userName: post.authorUserName,
                          avatar: post.authorAvatar,
                          headerOnTap: () {
                            if (post.author ==
                                FirebaseAuth.instance.currentUser!.uid) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MyProfilePgae(),
                                ),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProfilePgae(userId: post.author),
                                ),
                              );
                            }
                          },
                        ),
                      );
                    },
                  );
                } else {
                  // Handle the case when data is still loading
                  return const CircularProgressIndicator();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
