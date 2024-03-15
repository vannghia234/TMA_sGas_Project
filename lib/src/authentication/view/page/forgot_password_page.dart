import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgas/core/constants/constants.dart';
import 'package:sgas/core/utils/custom_color.dart';
import 'package:sgas/core/utils/custom_textstyle.dart';
import 'package:sgas/src/authentication/view/bloc/forget_pass_cubit.dart';
import 'package:sgas/src/authentication/view/bloc/forget_pass_state.dart';
import 'package:sgas/src/authentication/view/widgets/error_message.dart';
import 'package:sgas/src/authentication/view/widgets/label_textfield.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _username = TextEditingController();
  final _phoneNumber = TextEditingController();

  @override
  void dispose() {
    _username.dispose();
    _phoneNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text(
          'Cấp lại mật khẩu',
        ),
        titleTextStyle:
            CustomTextStyle.lable2(textColor: CustomColor.textPrimaryColor),
      ),
      body: Column(
        children: [
          Container(
            color: CustomColor.backgroundNeutralColor,
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
            child: Text(
              'Nhập email và số điện thoại, sau đó nhấn gửi mã OTP',
              style: CustomTextStyle.body2(
                  textColor: CustomColor.textSecondaryColor),
            ),
          ),
          const SizedBox(height: 24),
          BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getWidthScreen(context) * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const LabelTextField(title: "Tên đăng nhập"),
                    TextFormField(
                      controller: _username,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.fromLTRB(0, 10, 16, 10),
                        prefix: const SizedBox(width: 16),
                        border: _greyBorder(),
                        focusedBorder: _greyBorder(),
                        errorBorder: _errorBorder(),
                        error: (state is InvalidForgetUsername)
                            ? ErrorMessage(mess: state.message)
                            : null,
                        focusedErrorBorder: _greyBorder(),
                        enabledBorder: _greyBorder(),
                        disabledBorder: _greyBorder(),
                        hintText: 'Nhập tên đăng nhập',
                        hintStyle: CustomTextStyle.body1(
                            textColor: CustomColor.tertiaryColor),
                      ),
                      textInputAction: TextInputAction.done,
                      style: CustomTextStyle.body1(
                          textColor: CustomColor.textPrimaryColor),
                      cursorColor: CustomColor.textPrimaryColor,
                    ),
                    const SizedBox(height: 16),
                    const LabelTextField(title: "Số điện thoại"),
                    TextFormField(
                      controller: _phoneNumber,
                      onChanged: (value) {
                        //
                      },
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.fromLTRB(0, 10, 16, 10),
                        prefix: const SizedBox(width: 16),
                        border: _greyBorder(),
                        focusedBorder: _greyBorder(),
                        errorBorder: _errorBorder(),
                        error: (state is InvalidForgetPhoneNumber)
                            ? ErrorMessage(mess: state.message)
                            : null,
                        focusedErrorBorder: _greyBorder(),
                        enabledBorder: _greyBorder(),
                        disabledBorder: _greyBorder(),
                        hintText: 'Nhập số điện thoại',
                        hintStyle: CustomTextStyle.body1(
                            textColor: CustomColor.tertiaryColor),
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      style: CustomTextStyle.body1(
                          textColor: CustomColor.textPrimaryColor),
                      cursorColor: CustomColor.textPrimaryColor,
                    ),
                    const SizedBox(height: 24),
                    Container(
                      height: 48,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: CustomColor.primaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextButton(
                        onPressed: () async {
                          await context
                              .read<ForgetPasswordCubit>()
                              .handleForgetPasswordEvent(
                                  context, _username.text, _phoneNumber.text);
                        },
                        child: Text(
                          'Gửi mã OTP',
                          style:
                              CustomTextStyle.button1(textColor: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
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
