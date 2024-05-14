import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sgas/core/ui/resource/icon_path.dart';
import 'package:sgas/core/ui/style/base_color.dart';
import 'package:sgas/core/ui/style/base_text_style.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField(
      {super.key,
      this.controller,
      this.suffixIcon,
      this.onChange,
      this.isHidden,
      this.hintText,
      this.messageError,
      this.enable = true,
      required this.label,
      this.keyBoardType,
      this.suffixPath,
      this.suffixPathColor = BaseColor.greyNeutral300,
      this.prefixIcon,
      this.prefixPath,
      this.prefixPathColor = BaseColor.greyNeutral300})
      : assert(suffixPath == null || suffixIcon == null),
        assert(prefixPath == null || prefixIcon == null);
  final TextEditingController? controller;
  final ValueChanged<String>? onChange;
  final bool? isHidden;
  final String? hintText;
  final String? messageError;
  final String label;
  final TextInputType? keyBoardType;
  final bool enable;
  final Widget? suffixIcon;
  final String? suffixPath;
  final Color suffixPathColor;
  final Widget? prefixIcon;
  final String? prefixPath;
  final Color prefixPathColor;

  @override
  Widget build(BuildContext context) {
    final hasError = messageError != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _LabelTextField(
          title: label,
        ),
        TextField(
          controller: controller,
          enabled: enable,
          decoration: InputDecoration(
              filled: true,
              fillColor: (enable) ? Colors.white : BaseColor.greyNeutral60,
              contentPadding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
              border: hasError ? _errorBorder() : _greyBorder(),
              focusedBorder: hasError ? _errorBorder() : _focusBorder(),
              errorBorder: _errorBorder(),
              focusedErrorBorder: _errorBorder(),
              enabledBorder: hasError ? _errorBorder() : _greyBorder(),
              disabledBorder: _disableBorder(),
              hintText: hintText,
              hintStyle: BaseTextStyle.body1(color: BaseColor.textTertiary),
              suffixIcon: _mapSuffixToWidget(),
              prefixIcon: _mapPrefixToWidget()),
          onChanged: onChange,
          textInputAction: TextInputAction.done,
          keyboardType: keyBoardType ?? TextInputType.text,
          style: BaseTextStyle.body1(
              color: (enable)
                  ? BaseColor.textPrimaryColor
                  : BaseColor.greyNeutral600),
          cursorColor: BaseColor.textPrimaryColor,
          obscureText: isHidden ?? false,
        ),
        (messageError != null)
            ? _errorWidget(messageError)
            : const SizedBox.shrink()
      ],
    );
  }

  Widget? _mapSuffixToWidget() {
    if (suffixIcon != null) {
      return suffixIcon!;
    }
    if (suffixPath != null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 8, 10),
        child: SvgPicture.asset(
          suffixPath!,
          colorFilter: ColorFilter.mode(
              (!enable)
                  ? BaseColor.greyNeutral600
                  : (messageError != null)
                      ? BaseColor.alertColor
                      : suffixPathColor,
              BlendMode.srcIn),
        ),
      );
    }
    return null;
  }

  Widget? _mapPrefixToWidget() {
    if (prefixIcon != null) {
      return prefixIcon!;
    }
    if (prefixPath != null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 8, 10),
        child: SvgPicture.asset(
          prefixPath!,
          colorFilter: ColorFilter.mode(
              (!enable)
                  ? BaseColor.greyNeutral600
                  : (messageError != null)
                      ? BaseColor.alertColor
                      : prefixPathColor,
              BlendMode.srcIn),
        ),
      );
    }
    return null;
  }

  Widget _errorWidget(String? mess) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(IconPath.error),
          const SizedBox(
            width: 5,
          ),
          Flexible(
            child: Text(
              mess ?? "",
              style: BaseTextStyle.body3(color: BaseColor.alertColor),
            ),
          ),
        ],
      ),
    );
  }
}

OutlineInputBorder _focusBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: BaseColor.primaryColor, width: 1),
  );
}

OutlineInputBorder _greyBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: BaseColor.borderColor, width: 1),
  );
}

OutlineInputBorder _disableBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: BaseColor.greyNeutral200, width: 1),
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
      padding: const EdgeInsets.only(bottom: 4),
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
