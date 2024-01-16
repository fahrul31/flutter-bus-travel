import 'package:bus/common/styles.dart';
import 'package:flutter/material.dart';

class CustomSearch extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  const CustomSearch(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: thirdGrey,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Flexible(
              child: Icon(
                Icons.location_on_outlined,
                color: Colors.grey,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 4,
              child: TextField(
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                controller: controller,
                style: myTextTheme.bodyMedium,
                decoration: InputDecoration(
                  labelText: labelText,
                  labelStyle: myTextTheme.labelMedium,
                  hintText: hintText,
                  hintStyle: myTextTheme.labelMedium,
                  border: InputBorder.none,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
