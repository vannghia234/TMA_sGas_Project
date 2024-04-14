import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sgas/core/ui/resource/icon_path.dart';
import 'package:sgas/core/ui/style/base_color.dart';
import 'package:sgas/core/ui/style/base_text_style.dart';

class TextFieldCommon extends StatelessWidget {
  const TextFieldCommon(
      {super.key,
      this.controller,
      this.suffixIcon,
      this.onChange,
      this.isHidden,
      this.hintText,
      this.messageError,
      required this.label,
      this.keyBoardType});
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChange;
  final bool? isHidden;
  final String? hintText;
  final String? messageError;
  final String label;
  final TextInputType? keyBoardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _LabelTextField(
          title: label,
        ),
        TextField(
          controller: controller,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(0, 10, 16, 10),
              prefix: const SizedBox(width: 16),
              error: messageError != null ? _errorWidget(messageError) : null,
              border: _greyBorder(),
              focusedBorder: _greyBorder(),
              errorBorder: _errorBorder(), // màu đỏ
              focusedErrorBorder: _errorBorder(),
              enabledBorder: _greyBorder(),
              disabledBorder: _greyBorder(),
              hintText: hintText,
              hintStyle:
                  BaseTextStyle.body1(color: BaseColor.textSecondaryColor),
              suffixIcon: suffixIcon),
          onChanged: onChange,
          textInputAction: TextInputAction.done,
          keyboardType: keyBoardType ?? TextInputType.text,
          style: BaseTextStyle.body1(color: BaseColor.textPrimaryColor),
          cursorColor: BaseColor.textPrimaryColor,
          obscureText: isHidden ?? false,
        ),
      ],
    );
  }

  FittedBox _errorWidget(String? mess) {
    return FittedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(IconPath.error),
          const SizedBox(
            width: 5,
          ),
          Text(
            mess ?? "",
            style: BaseTextStyle.body3(color: BaseColor.alertColor),
          ),
        ],
      ),
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

class _LabelTextField extends StatelessWidget {
  const _LabelTextField({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text.rich(
        TextSpan(
          text: '$title ',
          style: BaseTextStyle.label2(color: BaseColor.textPrimaryColor),
          children: <InlineSpan>[
            TextSpan(
              text: '*',
              style: BaseTextStyle.label2(color: BaseColor.alertColor),
            ),
          ],
        ),
      ),
    );
  }
}
