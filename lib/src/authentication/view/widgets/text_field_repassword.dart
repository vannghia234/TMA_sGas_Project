import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgas/core/constants/icon_path.dart';
import 'package:sgas/core/utils/custom_color.dart';
import 'package:sgas/core/utils/custom_textstyle.dart';
import 'package:sgas/src/authentication/view/bloc/change_password_state.dart';
import 'package:sgas/src/authentication/view/bloc/change_re_password_cubit.dart';
import 'package:sgas/src/authentication/view/widgets/error_message.dart';
import 'package:sgas/src/authentication/view/widgets/label_textfield.dart';

class TextFieldRePassword extends StatefulWidget {
  const TextFieldRePassword({
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
  State<TextFieldRePassword> createState() => _TextFieldRePasswordState();
}

class _TextFieldRePasswordState extends State<TextFieldRePassword> {
  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangeRepasswordCubit, ChangePasswordState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LabelTextField(title: widget.title),
            TextFormField(
              controller: widget.controller,
              onChanged: (value) {
                if (value.length > 1) {
                  context
                      .read<ChangeRepasswordCubit>()
                      .changeState(InitialChangePassWord());
                }
                if (value.isEmpty) {
                  context.read<ChangeRepasswordCubit>().changeState(
                      InValidRePassword(message: "Không được để trống"));
                }
              },
              obscureText: (isHidden) ? true : false,
              decoration: InputDecoration(
                error: (state is InValidRePassword)
                    ? ErrorMessage(mess: state.message)
                    : null,
                suffixIcon: IconButton(
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    setState(() {
                      isHidden = !isHidden;
                    });
                  },
                  icon: Image.asset(
                    (isHidden)
                        ? IconPath.show_password
                        : IconPath.hide_password,
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
              style: CustomTextStyle.body1(
                  textColor: CustomColor.textPrimaryColor),
              cursorColor: CustomColor.textPrimaryColor,
              cursorErrorColor: CustomColor.textPrimaryColor,
            ),
          ],
        );
      },
    );
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
}
