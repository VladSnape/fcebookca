import 'package:facebookc/features/auth/view/pages/which_one.dart';
import 'package:facebookc/features/main/view/pages/main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthStatePage extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  AuthStatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const MainPage();
        } else {
          return const WhichOne();
        }
      },
    );
  }
}
