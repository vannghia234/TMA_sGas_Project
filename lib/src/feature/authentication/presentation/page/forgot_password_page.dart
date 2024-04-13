import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgas/core/config/dependency/dependency_config.dart';
import 'package:sgas/core/ui/style/base_color.dart';
import 'package:sgas/core/ui/style/base_text_style.dart';
import 'package:sgas/generated/l10n.dart';
import 'package:sgas/src/common/utils/controller/debounce_controller.dart';
import 'package:sgas/src/feature/authentication/presentation/bloc/forget_password/forget_pass_cubit.dart';
import 'package:sgas/src/feature/authentication/presentation/bloc/forget_password/forget_pass_state.dart';
import 'package:sgas/src/feature/authentication/presentation/widgets/notification_header.dart';
import 'package:sgas/src/common/presentation/widget/button/common_button.dart';
import 'package:sgas/src/common/presentation/widget/text_field/common_textfield.dart';

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
        centerTitle: false,
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
                    TextFieldCommon(
                      label: S.current.txt_username,
                      hintText: S.current.txt_enter_username,
                      controller: _username,
                      messageError: (state is InvalidForgetUsernameState)
                          ? state.message
                          : null,
                    ),
                    const SizedBox(height: 16),
                    TextFieldCommon(
                      label: S.current.txt_phone_number,
                      hintText: S.current.txt_enter_phone_number,
                      controller: _phoneNumber,
                      messageError: (state is InvalidForgetPhoneNumberState)
                          ? state.message
                          : null,
                    ),
                    const SizedBox(height: 24),
                    CommonButton(
                      buttonTitle: S.current.btn_send_otp,
                      onPress: () async {
                        getIt<DebounceController>().start(
                          function: () async {
                            await getIt
                                .get<ForgetPasswordCubit>()
                                .forgetPassword(
                                    _username.text, _phoneNumber.text, context);
                          },
                        );
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
