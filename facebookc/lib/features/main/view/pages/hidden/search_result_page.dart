// ignore_for_file: prefer_const_constructors

import 'package:facebookc/features/main/view/widgets/profiles_in_see_all_profile_page.dart';
import 'package:flutter/material.dart';

class SearchResultPage extends StatelessWidget {
  const SearchResultPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: 10,
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
