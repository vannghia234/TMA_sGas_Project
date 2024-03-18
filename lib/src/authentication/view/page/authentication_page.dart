import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sgas/core/constants/constants.dart';
import 'package:sgas/core/constants/icon_path.dart';
import 'package:sgas/core/constants/image_path.dart';
import 'package:sgas/core/utils/custom_color.dart';
import 'package:sgas/core/utils/custom_textstyle.dart';
import 'package:sgas/routes/route_path.dart';
import 'package:sgas/src/authentication/domain/entities/authentication_entity.dart';
import 'package:sgas/src/authentication/domain/usecases/authenticaion_usecase.dart';
import 'package:sgas/src/authentication/view/bloc/login_cubit.dart';
import 'package:sgas/src/authentication/view/utils/key_storage.dart';
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
  AuthenticationUseCase authUseCase = AuthenticationUseCase();
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: getHeightScreen(context) * 0.16),
                  Container(
                    height: 56,
                    width: 109,
                    child: SvgPicture.asset(
                      ImagePath.logoTMA,
                      // height: 56,
                      // width: 109,
                    ),
                  ),
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
                      onpress: () async {
                        handleButtonLogin();
                      },
                      isDisable: false)
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> handleButtonLogin() async {
    if (_username.text.isEmpty) {
      context.read<LoginCubit>().changeState(InValidUserName(message: "Bạn chưa nhập tên đăng nhập"));
      return;
    } else if (_password.text.isEmpty) {
      context.read<LoginCubit>().changeState(InValidPassWord(message: "Bạn chưa nhập mật khẩu"));
      return;
    } else {
      context.read<LoginCubit>().changeState(Successful());
      AuthenticationEntity entity = AuthenticationEntity(username: _username.text, password: _password.text);
      var res = await authUseCase.loginUseCase(entity);
      if (res.code == 200) {
        KeyStorage storage = KeyStorage();
        storage.save(accessToken: res.data!.token!.accessToken!, refreshToken: res.data!.token!.accessToken!);
        Navigator.pushNamed(context, RoutePath.home);
      } else if (res.code == 40001) {
        context.read<LoginCubit>().changeState(InValidPassWord(message: "Sai tên đăng nhập hoặc mật khẩu"));
      } else if (res.code == 40002) {
        context.read<LoginCubit>().changeState(InValidPassWord(message: "Tài khoản đã bị khóa"));
      } else if (res.code == 40003) {
        context.read<LoginCubit>().changeState(InValidPassWord(message: "Tài khoản của công ty bị khóa"));
      } else if (res.code == 40005) {
        context.read<LoginCubit>().changeState(InValidPassWord(message: "Tên tài khoản chỉ chứa kí tự a-z, A-Z, hoặc 0-9"));
      } else if (res.code == 40006) {
        context.read<LoginCubit>().changeState(InValidPassWord(message: "Tên tài khoản phải từ 6-50 kí tự"));
      } else if (res.code == 40007) {
        context.read<LoginCubit>().changeState(InValidPassWord(message: "Mật khẩu phải từ 6-50 kí tự"));
      }
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
                  SvgPicture.asset(IconPath.error),
                  Text(
                    '  ${state.message}',
                    style: CustomTextStyle.body3(textColor: CustomColor.semanticAlertColor),
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
          icon: SvgPicture.asset(
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
        style: CustomTextStyle.headingH4(textColor: CustomColor.textPrimaryColor),
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
    borderSide: const BorderSide(color: CustomColor.borderNeutralColor, width: 1),
  );
}

OutlineInputBorder _errorBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: CustomColor.semanticAlertColor, width: 1),
  );
}
