import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sgas/core/ui/resource/icon_path.dart';
import 'package:sgas/core/ui/style/base_color.dart';
import 'package:sgas/core/ui/style/base_style.dart';
import 'package:sgas/src/authentication/presentation/bloc/change_password_state.dart';
import 'package:sgas/src/authentication/presentation/bloc/change_re_password_cubit.dart';
import 'package:sgas/src/authentication/presentation/widgets/text_field_error_message.dart';
import 'package:sgas/src/authentication/presentation/widgets/label_textfield.dart';

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
                    ? TextFieldErrorMessage(mess: state.message)
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
}
