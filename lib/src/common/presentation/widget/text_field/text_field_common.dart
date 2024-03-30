import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sgas/core/ui/style/base_color.dart';
import 'package:sgas/core/ui/style/base_style.dart';

class TextFieldCommon extends StatelessWidget {
  const TextFieldCommon(
      {super.key,
      this.controller,
      this.error,
      this.suffixIcon,
      this.onChange,
      this.isHidden, this.hintText});
  final TextEditingController? controller;
  final Widget? error;
  final Widget? suffixIcon;
  final ValueChanged? onChange;
  final bool? isHidden;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(0, 10, 16, 10),
          prefix: const SizedBox(width: 16),
          error: error,
          border: _greyBorder(),
          focusedBorder: _greyBorder(),
          errorBorder: _greyBorder(), // màu đỏ
          focusedErrorBorder: _greyBorder(),
          enabledBorder: _greyBorder(),
          disabledBorder: _greyBorder(),
          hintText: hintText,
          hintStyle: BaseTextStyle.body1(color: BaseColor.textSecondaryColor),
          suffixIcon: suffixIcon),
      onChanged: onChange,
      textInputAction: TextInputAction.done,
      style: BaseTextStyle.body1(color: BaseColor.textPrimaryColor),
      cursorColor: BaseColor.textPrimaryColor,
      obscureText: isHidden ?? false,
      obscuringCharacter: '●',
    );
  }
}

OutlineInputBorder _greyBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: BaseColor.borderColor, width: 1),
  );
}

OutlineInputBorder _errorBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: BaseColor.alertColor, width: 1),
  );
}
