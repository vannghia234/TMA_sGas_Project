import 'package:flutter/material.dart';
import 'package:sgas/core/utils/custom_color.dart';
import 'package:sgas/core/utils/custom_textstyle.dart';
import 'package:sgas/routes/route_path.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _username = TextEditingController();
  final _phoneNumber = TextEditingController();

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
        titleTextStyle: CustomTextStyle.lable2(textColor: CustomColor.textPrimaryColor),
      ),
      body: Column(
        children: [
          Container(
            height: 72,
            color: CustomColor.backgroundNeutralColor,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            child: Text(
              'Nhập email và số điện thoại, sau đó nhấn gửi mã OTP',
              style: CustomTextStyle.body2(textColor: CustomColor.textSecondaryColor),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            height: 248,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text.rich(
                    TextSpan(
                      text: 'Tên đăng nhập ',
                      style: CustomTextStyle.lable2(textColor: CustomColor.textPrimaryColor),
                      children: <InlineSpan>[
                        TextSpan(
                          text: '*',
                          style: CustomTextStyle.lable2(textColor: CustomColor.semanticAlertColor),
                        ),
                      ],
                    ),
                  ),
                ),
                TextFormField(
                  controller: _username,
                  onChanged: (value) {
                    //
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(0, 10, 16, 10),
                    prefix: const SizedBox(width: 16),
                    border: _greyBorder(),
                    focusedBorder: _greyBorder(),
                    errorBorder: _errorBorder(),
                    // error: (state is AuthenticationFailed)
                    //     ? Row(
                    //         mainAxisAlignment: MainAxisAlignment.start,
                    //         children: [
                    //           Image.asset(IconPath.error),
                    //           Text(
                    //             '  ${state.message}',
                    //             style: CustomTextStyle.body3(textColor: CustomColor.semanticAlertColor),
                    //           ),
                    //         ],
                    //       )
                    //     : null,
                    focusedErrorBorder: _greyBorder(),
                    enabledBorder: _greyBorder(),
                    disabledBorder: _greyBorder(),
                    hintText: 'Nhập tên đăng nhập',
                    hintStyle: CustomTextStyle.body1(textColor: CustomColor.tertiaryColor),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  style: CustomTextStyle.body1(textColor: CustomColor.textPrimaryColor),
                  cursorColor: CustomColor.textPrimaryColor,
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text.rich(
                    TextSpan(
                      text: 'Số điện thoại ',
                      style: CustomTextStyle.lable2(textColor: CustomColor.textPrimaryColor),
                      children: <InlineSpan>[
                        TextSpan(
                          text: '*',
                          style: CustomTextStyle.lable2(textColor: CustomColor.semanticAlertColor),
                        ),
                      ],
                    ),
                  ),
                ),
                TextFormField(
                  controller: _phoneNumber,
                  onChanged: (value) {
                    //
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(0, 10, 16, 10),
                    prefix: const SizedBox(width: 16),
                    border: _greyBorder(),
                    focusedBorder: _greyBorder(),
                    errorBorder: _errorBorder(),
                    // error: (state is AuthenticationFailed)
                    //     ? Row(
                    //         mainAxisAlignment: MainAxisAlignment.start,
                    //         children: [
                    //           Image.asset(IconPath.error),
                    //           Text(
                    //             '  ${state.message}',
                    //             style: CustomTextStyle.body3(textColor: CustomColor.semanticAlertColor),
                    //           ),
                    //         ],
                    //       )
                    //     : null,
                    focusedErrorBorder: _greyBorder(),
                    enabledBorder: _greyBorder(),
                    disabledBorder: _greyBorder(),
                    hintText: 'Nhập số điện thoại',
                    hintStyle: CustomTextStyle.body1(textColor: CustomColor.tertiaryColor),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  style: CustomTextStyle.body1(textColor: CustomColor.textPrimaryColor),
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
                    onPressed: () {
                      Navigator.pushNamed(context, RoutePath.recieveOTP);
                    },
                    child: Text(
                      'Gửi mã OTP',
                      style: CustomTextStyle.button1(textColor: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

OutlineInputBorder _greyBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: CustomColor.borderNeutralColor, width: 1),
  );
}

OutlineInputBorder _errorBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: CustomColor.semanticAlertColor, width: 1),
  );
}
