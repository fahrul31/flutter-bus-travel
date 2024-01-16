import 'package:bus/common/styles.dart';
import 'package:flutter/material.dart';

class CustomBox extends StatelessWidget {
  final String text;

  const CustomBox({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: charcoalGrey,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 17),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                text,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 20,
                color: Colors.grey,
              )
            ],
          ),
        ),
      ),
    );
  }
}
