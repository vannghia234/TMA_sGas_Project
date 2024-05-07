import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgas/core/config/dependency/dependency_config.dart';
import 'package:sgas/generated/l10n.dart';
import 'package:sgas/src/common/presentation/widget/button/common_button.dart';
import 'package:sgas/src/common/presentation/widget/text_field/common_textfield.dart';
import 'package:sgas/src/common/util/controller/loading_controller.dart';
import 'package:sgas/src/feature/authentication/presentation/bloc/forget_password/forget_password__page_cubit.dart';
import 'package:sgas/src/feature/authentication/presentation/bloc/forget_password/forget_password_page_state.dart';
import 'package:sgas/src/feature/authentication/presentation/bloc/forget_password/forget_password_cubit.dart';

class ForgetForm extends StatelessWidget {
  const ForgetForm({
    super.key,
    required TextEditingController username,
    required TextEditingController phoneNumber,
  })  : _username = username,
        _phoneNumber = phoneNumber;

  final TextEditingController _username;
  final TextEditingController _phoneNumber;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgetPasswordPageCubit, ForgetPasswordState>(
      bloc: getIt.get<ForgetPasswordPageCubit>(),
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
                keyBoardType: TextInputType.phone,
                controller: _phoneNumber,
                messageError: (state is InvalidForgetPhoneNumberState)
                    ? state.message
                    : null,
              ),
              const SizedBox(height: 24),
              CommonButton(
                buttonTitle: S.current.btn_send_otp,
                onPress: () async {
                  getIt.get<LoadingController>().start(context);
                  await getIt
                      .get<ForgetPasswordCubit>()
                      .forgetPassword(_username.text, _phoneNumber.text)
                      .whenComplete(
                          () => getIt.get<LoadingController>().close(context));
                },
              )
            ],
          ),
        );
      },
    );
  }
}
