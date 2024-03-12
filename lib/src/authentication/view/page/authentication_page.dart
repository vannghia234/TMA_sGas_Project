import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgas/core/constants/icon_path.dart';
import 'package:sgas/core/constants/image_path.dart';
import 'package:sgas/core/utils/custom_color.dart';
import 'package:sgas/core/utils/custom_textstyle.dart';
import 'package:sgas/routes/route_path.dart';
import 'package:sgas/src/authentication/view/bloc/authentication_bloc.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final _username = TextEditingController();
  final _password = TextEditingController();

  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationSuccessfull) {
            Navigator.pushNamed(context, RoutePath.home);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 160),
                  Image.asset(ImagePath.logoTMA),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 40, 0, 40),
                    child: Text(
                      'Đăng nhập',
                      style: CustomTextStyle.headingH4(textColor: CustomColor.textPrimaryColor),
                    ),
                  ),
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
                      context.read<AuthenticationBloc>().add(const AuthenticationInitialEvent());
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(0, 10, 16, 10),
                      prefix: const SizedBox(width: 16),
                      border: _greyBorder(),
                      focusedBorder: _greyBorder(),
                      errorBorder: _errorBorder(),
                      error: (state is AuthenticationFailed)
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(IconPath.error),
                                Text(
                                  '  ${state.message}',
                                  style: CustomTextStyle.body3(textColor: CustomColor.semanticAlertColor),
                                ),
                              ],
                            )
                          : null,
                      focusedErrorBorder: _errorBorder(),
                      enabledBorder: _greyBorder(),
                      disabledBorder: _greyBorder(),
                      hintText: 'Nhập tên đăng nhập',
                      hintStyle: CustomTextStyle.body1(textColor: CustomColor.tertiaryColor),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    style: CustomTextStyle.body1(textColor: CustomColor.textPrimaryColor),
                    cursorColor: CustomColor.textPrimaryColor,
                    cursorErrorColor: CustomColor.textPrimaryColor,
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text.rich(
                      TextSpan(
                        text: 'Mật khẩu ',
                        style: CustomTextStyle.lable2(textColor: CustomColor.textPrimaryColor),
                        children: <InlineSpan>[
                          TextSpan(
                            text: '*',
                            style: CustomTextStyle.lable2(textColor: CustomColor.semanticAlertColor),
                          )
                        ],
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _password,
                    onChanged: (value) {
                      //
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(0, 10, 16, 10),
                      prefix: const SizedBox(width: 16),
                      border: _greyBorder(),
                      focusedBorder: _greyBorder(),
                      errorBorder: _greyBorder(), // màu đỏ
                      focusedErrorBorder: _greyBorder(),
                      enabledBorder: _greyBorder(),
                      disabledBorder: _greyBorder(),
                      hintText: 'Nhập mật khẩu',
                      hintStyle: CustomTextStyle.body1(textColor: CustomColor.tertiaryColor),
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
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    style: CustomTextStyle.body1(textColor: CustomColor.textPrimaryColor),
                    cursorColor: CustomColor.textPrimaryColor,
                    obscureText: isHidden,
                    obscuringCharacter: '●',
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 24),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RoutePath.forgotPassword);
                        },
                        child: Text(
                          'Quên mật khẩu?',
                          style: CustomTextStyle.button1(textColor: CustomColor.primaryColor),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 48,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: CustomColor.primaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextButton(
                      onPressed: () {
                        context.read<AuthenticationBloc>().add(
                              Login(email: _username.text, password: _password.text),
                            );
                      },
                      child: Text(
                        'Đăng nhập',
                        style: CustomTextStyle.button1(textColor: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
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
