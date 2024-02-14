import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebookc/features/auth/domain/model/user_model.dart';
import 'package:facebookc/features/main/view/pages/hidden/my_profile_page.dart';
import 'package:facebookc/features/main/view/pages/hidden/profile_page.dart';
import 'package:facebookc/features/main/view/widgets/comment_text_field.dart';
import 'package:facebookc/features/main/view/widgets/profiles_in_see_all_profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OnSearchingPage extends StatefulWidget {
  const OnSearchingPage({Key? key}) : super(key: key);

  @override
  _OnSearchingPageState createState() => _OnSearchingPageState();
}

class _OnSearchingPageState extends State<OnSearchingPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CommentTextField(
          controller: _searchController,
          onSubmitted: (query) {
            // Perform search when the user submits the query
            _performSearch(query);
          },
          text: "Search",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      "Recent",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ],
              ),
              FutureBuilder<QuerySnapshot>(
                future: _searchUsers(_searchController.text),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Text("No results found");
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var userData = snapshot.data!.docs[index].data()
                            as Map<String, dynamic>;
                        UserModel userModel = UserModel.fromMap(userData);
                        return ProfileInSeeAllProfilePage(
                          avatar: userModel.avatarImage,
                          userName: userModel.userName,
                          onTap: () {
                            if (userModel.id ==
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
                                      ProfilePgae(userId: userModel.id),
                                ),
                              );
                            }
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<QuerySnapshot> _searchUsers(String query) {
    // Perform a case-insensitive search on the 'userName' field
    return FirebaseFirestore.instance
        .collection('users')
        .orderBy('userName')
        .startAt([query.toLowerCase()]).endAt(
            [query.toLowerCase() + '\uf8ff']).get();
  }

  void _performSearch(String query) {
    // Trigger a new search when the user submits the query
    print(" that is the querry === $query");
    setState(() {});
  }
}
