import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CommentTextField extends StatelessWidget {
  final FocusNode? focusNode;
  final TextEditingController? controller;
  void Function(String)? onSubmitted;
  final String text;
  CommentTextField({
    Key? key,
    this.onSubmitted,
    required this.text,
    this.controller,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          focusNode: focusNode,
          controller: controller,
          onSubmitted: onSubmitted,
          style: Theme.of(context).textTheme.titleSmall,
          decoration: InputDecoration(
            hintText: text,
            hintStyle: Theme.of(context).textTheme.displaySmall,
            fillColor: Theme.of(context).secondaryHeaderColor,
            filled: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 10),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
    );
  }
}
