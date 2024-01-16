import 'package:bus/common/styles.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final bool visibleIcon;
  final TextEditingController controller;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.visibleIcon,
    required this.hintText,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool obscureText = false;

  @override
  void initState() {
    // TODO: implement initState
    if (widget.hintText.toLowerCase() == "password") {
      obscureText = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: MediaQuery.of(context).size.width,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: charcoalGrey,
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: myTextTheme.bodyMedium,
          textAlign: TextAlign.left,
          textAlignVertical: TextAlignVertical.center,
          cursorColor: Colors.white,
          controller: widget.controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 22,
            ),
            hintStyle: myTextTheme.labelMedium,
            hintText: widget.hintText,
            filled: true,
            fillColor: charcoalGrey,
            suffixIcon: Visibility(
              visible: widget.visibleIcon,
              child: IconButton(
                icon: Icon(widget.visibleIcon
                    ? Icons.visibility
                    : Icons.visibility_off),
                color: Colors.white,
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
              ),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}
