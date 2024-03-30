import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgas/core/helper/screen_helper.dart';
import 'package:sgas/core/ui/style/base_color.dart';
import 'package:sgas/core/ui/style/base_style.dart';
import 'package:sgas/src/authentication/presentation/bloc/forget_pass_cubit.dart';
import 'package:sgas/src/authentication/presentation/bloc/forget_pass_state.dart';
import 'package:sgas/src/authentication/presentation/widgets/text_field_error_message.dart';
import 'package:sgas/src/authentication/presentation/widgets/label_textfield.dart';
import 'package:sgas/src/common/presentation/widget/button/button_primary.dart';
import 'package:sgas/src/common/presentation/widget/text_field/text_field_common.dart';

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
        titleTextStyle: BaseTextStyle.label2(color: BaseColor.textPrimaryColor),
      ),
      body: Column(
        children: [
          Container(
            color: BaseColor.backgroundNeutralColor,
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
            child: Text(
              'Nhập email và số điện thoại, sau đó nhấn gửi mã OTP',
              style: BaseTextStyle.body2(color: BaseColor.textSecondaryColor),
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
                    TextFieldCommon(
                      hintText: "Nhập tên đăng nhập",
                      controller: _username,
                      error: (state is InvalidForgetUsername)
                          ? TextFieldErrorMessage(mess: state.message)
                          : null,
                    ),
                    const SizedBox(height: 16),
                    const LabelTextField(title: "Số điện thoại"),
                    TextFieldCommon(
                      hintText: "Nhập số điện thoại",
                      controller: _phoneNumber,
                      error: (state is InvalidForgetPhoneNumber)
                          ? TextFieldErrorMessage(mess: state.message)
                          : null,
                    ),
                    const SizedBox(height: 24),
                    PrimaryButton(
                      buttonTitle: "Gửi mã OTP",
                      onPress: () async {
                        await context
                            .read<ForgetPasswordCubit>()
                            .handleForgetPasswordEvent(
                                context, _username.text, _phoneNumber.text);
                      },
                    )
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
    borderSide: const BorderSide(color: BaseColor.borderColor, width: 1),
  );
}

OutlineInputBorder _errorBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: BaseColor.alertColor, width: 1),
  );
}