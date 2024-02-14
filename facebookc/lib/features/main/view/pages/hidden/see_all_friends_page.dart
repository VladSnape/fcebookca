import 'package:facebookc/features/main/view/widgets/profiles_in_see_all_profile_page.dart';
import 'package:flutter/material.dart';

class SeeAllFriednsPage extends StatelessWidget {
  const SeeAllFriednsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return ProfileInSeeAllProfilePage(
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => ProfilePgae(),
              //     ));
            },
          );
        },
      ),
    );
  }
}
