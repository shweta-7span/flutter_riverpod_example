import 'package:flutter/material.dart';

import 'size_fade_switcher.dart';

class CustomTextInput extends StatelessWidget {
  const CustomTextInput({
    Key? key,
    required this.hintText,
    required this.onChange,
    this.errorText,
    this.obscureText = false,
    this.validator,
    required this.controller,
  }) : super(key: key);

  final String hintText;
  final void Function(String value) onChange;
  final String? errorText;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    debugPrint('CustomTextInput errorText: $errorText');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.black26,
                width: 1.5,
              )),
          child: TextFormField(
            validator: validator,
            onChanged: onChange,
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 11),
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
          ),
        ),
        SizeFadeSwitcher(
          child: (errorText == null)
              ? const SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
                  child: Text(
                    errorText!,
                    style: TextStyle(color: Theme.of(context).errorColor),
                  ),
                ),
        )
      ],
    );
  }
}
