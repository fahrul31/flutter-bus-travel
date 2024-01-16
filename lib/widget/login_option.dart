import 'package:flutter/material.dart';

class LoginOptionsWidget extends StatelessWidget {
  const LoginOptionsWidget({super.key, required this.image});

  final String image;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      width: 52,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFFEEEEEE),
        ),
        child: Center(
          child: Image.asset(image),
        ),
      ),
    );
  }
}
