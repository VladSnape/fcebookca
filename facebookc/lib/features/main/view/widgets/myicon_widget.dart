import 'package:flutter/material.dart';

class MyIconButton extends StatelessWidget {
  final IconData? icon;
  const MyIconButton({
    super.key,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const ShapeDecoration(
          shape: CircleBorder(), color: Color.fromARGB(137, 198, 198, 198)),
      child: IconButton(
        icon: Icon(icon),
        onPressed: () {},
      ),
    );
  }
}
