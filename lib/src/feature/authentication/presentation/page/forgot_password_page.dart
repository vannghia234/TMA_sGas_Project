import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgas/core/config/dependency/dependency_config.dart';
import 'package:sgas/core/ui/style/base_color.dart';
import 'package:sgas/core/ui/style/base_text_style.dart';
import 'package:sgas/generated/l10n.dart';
import 'package:sgas/src/feature/authentication/presentation/bloc/forget_password/forget_pass_cubit.dart';
import 'package:sgas/src/feature/authentication/presentation/bloc/forget_password/forget_pass_state.dart';
import 'package:sgas/src/feature/authentication/presentation/widgets/notification_header.dart';
import 'package:sgas/src/feature/authentication/presentation/widgets/error_message_textfield.dart';
import 'package:sgas/src/feature/authentication/presentation/widgets/label_textfield.dart';
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
        title: Text(
          S.current.txt_confirm_password,
        ),
        titleTextStyle: BaseTextStyle.label2(color: BaseColor.textPrimaryColor),
      ),
      body: Column(
        children: [
          NotificationHeader(
            title: S.current.txt_instructions,
          ),
          const SizedBox(height: 24),
          BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
            bloc: getIt.get<ForgetPasswordCubit>(),
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LabelTextField(title: S.current.txt_username),
                    TextFieldCommon(
                      hintText: S.current.txt_enter_username,
                      controller: _username,
                      error: (state is InvalidForgetUsernameState)
                          ? ErrorMessageTextField(mess: state.message)
                          : null,
                    ),
                    const SizedBox(height: 16),
                    LabelTextField(title: S.current.txt_phone_number),
                    TextFieldCommon(
                      hintText: S.current.txt_enter_phone_number,
                      controller: _phoneNumber,
                      error: (state is InvalidForgetPhoneNumberState)
                          ? ErrorMessageTextField(mess: state.message)
                          : null,
                    ),
                    const SizedBox(height: 24),
                    PrimaryButton(
                      buttonTitle: S.current.btn_send_otp,
                      onPress: () async {
                        await getIt
                            .get<ForgetPasswordCubit>()
                            .forgetPassword(_username.text, _phoneNumber.text);
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
