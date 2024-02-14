import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final bool obscure;
  const LoginTextField({
    super.key,
    required this.controller,
    required this.text,
    required this.obscure,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscure,
      controller: controller,
      style: const TextStyle(
          color: Color.fromARGB(255, 231, 252, 255),
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
          fontSize: 16),
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 177, 229, 255),
            )),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Colors.blueGrey,
            )),
        hintText: text,
        hintStyle: const TextStyle(
            color: Colors.blueGrey, fontFamily: 'Poppins', fontSize: 16),
      ),
    );
  }
}
