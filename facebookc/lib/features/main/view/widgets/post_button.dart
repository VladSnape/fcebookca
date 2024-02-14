import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PostButtonWidget extends StatelessWidget {
  void Function()? onTap;
  bool isEmpty;
  PostButtonWidget({
    Key? key,
    this.onTap,
    required this.isEmpty,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
      decoration: BoxDecoration(
          color:
              isEmpty ? const Color.fromARGB(255, 210, 210, 210) : Colors.blue,
          borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: onTap,
        child: const Text(
          "POST",
          style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 16),
        ),
      ),
    );
  }
}
