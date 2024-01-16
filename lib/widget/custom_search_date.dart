import 'package:bus/common/styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDateSearch extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  const CustomDateSearch(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.hintText});

  @override
  State<CustomDateSearch> createState() => _CustomDateSearchState();
}

class _CustomDateSearchState extends State<CustomDateSearch> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: thirdGrey,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: TextField(
            controller: widget.controller,
            style: myTextTheme.bodyMedium,
            readOnly: true,
            onTap: () async {
              DateTime? pickDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2030),
              );

              if (pickDate != null) {
                setState(() {
                  DateFormat dateFormat = DateFormat('dd MMM yyyy');
                  widget.controller.text = dateFormat.format(pickDate);
                });
              }
            },
            decoration: InputDecoration(
              labelText: widget.labelText,
              labelStyle: myTextTheme.labelMedium,
              hintText: widget.hintText,
              hintStyle: myTextTheme.labelMedium,
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
