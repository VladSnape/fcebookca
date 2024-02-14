import 'package:facebookc/features/auth/view/pages/login_page.dart';
import 'package:facebookc/features/auth/view/pages/registre_page.dart';
import 'package:flutter/material.dart';

class WhichOne extends StatefulWidget {
  const WhichOne({super.key});

  @override
  State<WhichOne> createState() => _WhichOneState();
}

class _WhichOneState extends State<WhichOne> {
  bool login = false;
  void toggleLogin() {
    setState(() {
      login = !login;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (login) {
      return LoginPage(
        toggle: toggleLogin,
      );
    } else {
      return RegistrePage(
        toggle: toggleLogin,
      );
    }
  }
}
