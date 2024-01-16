import 'package:bus/common/styles.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double height;

  const CustomButton({
    super.key,
    required this.text,
    required this.height,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: amberYellow),
        child: Center(
          child: Text(text, style: myTextTheme.labelLarge),
        ),
      ),
    );
  }
}
