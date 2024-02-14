import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  final bool isWhite;
  final String text;
  final double borderRadius;
  final Color color;
  final double width;
  final double? height;

  const MyContainer({
    super.key,
    required this.text,
    required this.borderRadius,
    required this.color,
    required this.width,
    required this.isWhite,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(borderRadius)),
      child: Center(
          child: Text(
        text,
        style: isWhite
            ? Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: Colors.white)
            : Theme.of(context).textTheme.titleSmall,
      )),
    );
  }
}
