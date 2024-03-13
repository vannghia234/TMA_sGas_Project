import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgas/core/constants/icon_path.dart';
import 'package:sgas/core/utils/custom_color.dart';
import 'package:sgas/core/utils/custom_textstyle.dart';
import 'package:sgas/src/authentication/view/bloc/change_new_repassword_cubit.dart';

class TextFieldRePassword extends StatefulWidget {
  const TextFieldRePassword(
      {super.key,
      required this.controller,
      required this.title,
      required this.hintText,
      required this.isObsuretext,
      required this.error});
  final TextEditingController controller;
  final String title;
  final String hintText;
  final bool isObsuretext;
  final String error;

  @override
  State<TextFieldRePassword> createState() => _TextFieldRePasswordState();
}

class _TextFieldRePasswordState extends State<TextFieldRePassword> {
  bool isHidden = true;
  bool isEnoughCharacter = false;
  bool isContainNumber = false;
  bool isContainLetter = false;
  bool isEmpty = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text.rich(
            TextSpan(
              text: '${widget.title} ',
              style: CustomTextStyle.lable2(
                  textColor: CustomColor.textPrimaryColor),
              children: <InlineSpan>[
                TextSpan(
                  text: '*',
                  style: CustomTextStyle.lable2(
                      textColor: CustomColor.semanticAlertColor),
                ),
              ],
            ),
          ),
        ),
        TextFormField(
          controller: widget.controller,
          onChanged: (value) {
            validateValue(value);

            context.read<ChangeNewRePasswordCubit>().changeState(
                isContainLetter: isContainLetter,
                err: (isEmpty) ? "Vui lòng không để trống" : "",
                isContainNumber: isContainNumber,
                isEnoughCharacter: isEnoughCharacter);
          },
          obscureText: (isHidden) ? true : false,
          decoration: InputDecoration(
            error: widget.error.isNotEmpty
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(IconPath.error),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget.error,
                        style: CustomTextStyle.body3(
                            textColor: CustomColor.semanticAlertColor),
                      ),
                    ],
                  )
                : null,
            suffixIcon: IconButton(
              highlightColor: Colors.transparent,
              onPressed: () {
                setState(() {
                  isHidden = !isHidden;
                });
              },
              icon: Image.asset(
                (isHidden) ? IconPath.show_password : IconPath.hide_password,
                fit: BoxFit.scaleDown,
              ),
            ),
            contentPadding: const EdgeInsets.fromLTRB(0, 10, 16, 10),
            prefix: const SizedBox(width: 16),
            border: _greyBorder(),
            focusedBorder: _greyBorder(),
            errorBorder: _errorBorder(),
            focusedErrorBorder: _errorBorder(),
            enabledBorder: _greyBorder(),
            disabledBorder: _greyBorder(),
            hintText: widget.hintText,
            hintStyle:
                CustomTextStyle.body1(textColor: CustomColor.tertiaryColor),
          ),
          keyboardType: (widget.isObsuretext)
              ? TextInputType.text
              : TextInputType.emailAddress,
          textInputAction: TextInputAction.done,
          style: CustomTextStyle.body1(textColor: CustomColor.textPrimaryColor),
          cursorColor: CustomColor.textPrimaryColor,
          cursorErrorColor: CustomColor.textPrimaryColor,
        ),
      ],
    );
  }

  void validateValue(String value) {
    RegExp regexNumber = RegExp(r'\d');
    RegExp regexLetter = RegExp(r'[a-zA-Z]'); // Biểu thức chính quy

    if (value.length >= 8) {
      isEnoughCharacter = true;
    } else {
      isEnoughCharacter = false;
    }

    if (value.isEmpty) {
      isEmpty = true;
    } else {
      isEmpty = false;
    }

    if (regexNumber.hasMatch(value)) {
      isContainNumber = true;
    } else {
      isContainNumber = false;
    }
    if (regexLetter.hasMatch(value)) {
      isContainLetter = true;
    } else {
      isContainLetter = false;
    }
  }
}

OutlineInputBorder _greyBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide:
        const BorderSide(color: CustomColor.borderNeutralColor, width: 1),
  );
}

OutlineInputBorder _errorBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide:
        const BorderSide(color: CustomColor.semanticAlertColor, width: 1),
  );
}
