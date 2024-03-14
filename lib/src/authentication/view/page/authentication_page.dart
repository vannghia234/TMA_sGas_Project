import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgas/core/constants/constants.dart';
import 'package:sgas/core/constants/icon_path.dart';
import 'package:sgas/core/constants/image_path.dart';
import 'package:sgas/core/utils/custom_color.dart';
import 'package:sgas/core/utils/custom_textstyle.dart';
import 'package:sgas/routes/route_path.dart';
import 'package:sgas/src/authentication/view/bloc/login_cubit.dart';
import 'package:sgas/src/authentication/view/widgets/label_textfield.dart';
import 'package:sgas/src/authentication/view/widgets/primary_button.dart';

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
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: BlocBuilder<LoginCubit, LoginState>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: getHeightScreen(context) * 0.16),
                      Image.asset(ImagePath.logoTMA),
                      const _TitleLogin(),
                      const LabelTextField(
                        title: 'Tên đăng nhập',
                      ),
                      _formUserName(state, context),
                      SizedBox(height: getHeightScreen(context) * 0.02),
                      const LabelTextField(title: "Mật khẩu"),
                      _formPassword(state, context),
                      const _ForgetPasswordText(),
                      PrimaryButton(
                          text: "Đăng nhập",
                          onpress: () {
                            _handleLogin(context);
                          },
                          isDisable: false)
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  void _handleLogin(BuildContext context) {
    if (_username.text.isEmpty) {
      context
          .read<LoginCubit>()
          .changeState(InValidUserName(message: "Bạn chưa nhập tên đăng nhập"));
    } else if (_password.text.isEmpty) {
      context
          .read<LoginCubit>()
          .changeState(InValidPassWord(message: "Bạn chưa nhập tên mật khẩu"));
    } else {
      context.read<LoginCubit>().changeState(Successful());
    }
  }

  TextFormField _formPassword(LoginState state, BuildContext context) {
    return TextFormField(
      controller: _password,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(0, 10, 16, 10),
        prefix: const SizedBox(width: 16),
        error: (state is InValidPassWord)
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(IconPath.error),
                  Text(
                    '  ${state.message}',
                    style: CustomTextStyle.body3(
                        textColor: CustomColor.semanticAlertColor),
                  ),
                ],
              )
            : null,
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
      onChanged: (value) {
        context.read<LoginCubit>().changeState(initial());
      },
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      style: CustomTextStyle.body1(textColor: CustomColor.textPrimaryColor),
      cursorColor: CustomColor.textPrimaryColor,
      obscureText: isHidden,
      obscuringCharacter: '●',
    );
  }

  TextFormField _formUserName(LoginState state, BuildContext context) {
    return TextFormField(
      controller: _username,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(0, 10, 16, 10),
        prefix: const SizedBox(width: 16),
        border: _greyBorder(),
        focusedBorder: _greyBorder(),
        errorBorder: _errorBorder(),
        error: (state is InValidUserName)
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(IconPath.error),
                  Text(
                    '  ${state.message}',
                    style: CustomTextStyle.body3(
                        textColor: CustomColor.semanticAlertColor),
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
      onChanged: (value) {
        context.read<LoginCubit>().changeState(initial());
      },
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.done,
      style: CustomTextStyle.body1(textColor: CustomColor.textPrimaryColor),
      cursorColor: CustomColor.textPrimaryColor,
      cursorErrorColor: CustomColor.textPrimaryColor,
    );
  }
}

class _TitleLogin extends StatelessWidget {
  const _TitleLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 40, 0, 40),
      child: Text(
        'Đăng nhập',
        style:
            CustomTextStyle.headingH4(textColor: CustomColor.textPrimaryColor),
      ),
    );
  }
}

class _ForgetPasswordText extends StatelessWidget {
  const _ForgetPasswordText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
