import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sgas/core/ui/resource/icon_path.dart';
import 'package:sgas/core/ui/style/base_color.dart';
import 'package:sgas/core/ui/style/base_style.dart';
import 'package:sgas/src/authentication/presentation/bloc/change_password_cubit.dart';
import 'package:sgas/src/authentication/presentation/bloc/change_password_state.dart';
import 'package:sgas/src/authentication/presentation/widgets/text_field_error_message.dart';
import 'package:sgas/src/authentication/presentation/widgets/label_textfield.dart';

class TextFieldPassowrd extends StatefulWidget {
  const TextFieldPassowrd({
    super.key,
    required this.controller,
    required this.title,
    required this.hintText,
    required this.isObsuretext,
  });
  final TextEditingController controller;
  final String title;
  final String hintText;
  final bool isObsuretext;

  @override
  State<TextFieldPassowrd> createState() => _TextFieldPassowrdState();
}

class _TextFieldPassowrdState extends State<TextFieldPassowrd> {
  bool isHidden = true;
  bool isEnoughCharacter = false;
  bool isContainNumber = false;
  bool isContainLetter = false;
  bool isEmpty = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LabelTextField(title: widget.title),
            TextFormField(
              controller: widget.controller,
              onChanged: (value) {
                handleOnChange(value, context);
              },
              obscureText: (isHidden) ? true : false,
              decoration: InputDecoration(
                error: (state is InValidPassword && state.message != "")
                    ? TextFieldErrorMessage(
                        mess: state.message,
                      )
                    : null,
                suffixIcon: IconButton(
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    setState(() {
                      isHidden = !isHidden;
                    });
                  },
                  icon: SvgPicture.asset(
                    (isHidden) ? IconPath.showPassword : IconPath.hidePassword,
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
                    BaseTextStyle.body1(color: BaseColor.textTertiaryColor),
              ),
              keyboardType: (widget.isObsuretext)
                  ? TextInputType.text
                  : TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              style: BaseTextStyle.body1(color: BaseColor.textPrimaryColor),
              cursorColor: BaseColor.textPrimaryColor,
              cursorErrorColor: BaseColor.textPrimaryColor,
            ),
          ],
        );
      },
    );
  }

  void handleOnChange(String value, BuildContext context) {
    if (value.length > 1) {
      context.read<ChangePasswordCubit>().changeState(InitialChangePassWord());
    }
    validateValue(value);
    if (isEmpty) {
      context
          .read<ChangePasswordCubit>()
          .changeState(InValidPassword(message: "Vui lòng không để trống"));
    }
    if (isContainLetter && isContainNumber && isEnoughCharacter) {
      context.read<ChangePasswordCubit>().changeState(
            InValidPassword(
                isContainLetter: true,
                isContainNumber: true,
                isEnoughCharacter: true),
          );
    } else if (isContainNumber & isContainLetter) {
      context.read<ChangePasswordCubit>().changeState(
            InValidPassword(isContainLetter: true, isContainNumber: true),
          );
    } else if (isContainNumber && isEnoughCharacter) {
      context.read<ChangePasswordCubit>().changeState(
            InValidPassword(isEnoughCharacter: true, isContainNumber: true),
          );
    } else if (isContainLetter && isEnoughCharacter) {
      context.read<ChangePasswordCubit>().changeState(
            InValidPassword(isEnoughCharacter: true, isContainLetter: true),
          );
    } else if (isContainLetter) {
      context.read<ChangePasswordCubit>().changeState(
            InValidPassword(isContainLetter: true),
          );
    } else if (isContainNumber) {
      context.read<ChangePasswordCubit>().changeState(
            InValidPassword(isContainNumber: true),
          );
    } else if (isEnoughCharacter) {
      context.read<ChangePasswordCubit>().changeState(
            InValidPassword(isEnoughCharacter: true),
          );
    }
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
    borderSide: const BorderSide(color: BaseColor.borderColor, width: 1),
  );
}

OutlineInputBorder _errorBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: BaseColor.alertColor, width: 1),
  );
}
