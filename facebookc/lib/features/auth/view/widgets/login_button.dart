import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final bool isprimary;
  final String text;
  final void Function()? onTap;
  const LoginButton({
    super.key,
    required this.isprimary,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                width: 2,
                color: isprimary
                    ? Colors.transparent
                    : const Color.fromARGB(255, 177, 229, 255)),
            borderRadius: BorderRadius.circular(50),
            color: isprimary
                ? const Color.fromARGB(255, 0, 76, 255)
                : Colors.transparent),
        height: MediaQuery.sizeOf(context).height * 0.07,
        width: MediaQuery.sizeOf(context).width,
        child: Center(
            child: Text(
          text,
          style: TextStyle(
              fontFamily: 'Poppins',
              color: isprimary
                  ? Colors.white
                  : const Color.fromARGB(255, 177, 229, 255),
              fontWeight: FontWeight.bold,
              fontSize: 18),
        )),
      ),
    );
  }
}

class LogoutButton extends StatelessWidget {
  final bool isPrimary;
  final String text;
  final void Function()? onTap;
  const LogoutButton({
    super.key,
    required this.text,
    this.onTap,
    required this.isPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isPrimary
              ? Colors.redAccent
              : Theme.of(context).secondaryHeaderColor,
        ),
        height: MediaQuery.sizeOf(context).height * 0.05,
        width: MediaQuery.sizeOf(context).width,
        child: Center(
            child: Text(
          text,
          style: Theme.of(context).textTheme.titleSmall,
        )),
      ),
    );
  }
}
