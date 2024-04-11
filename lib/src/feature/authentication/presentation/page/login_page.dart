import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sgas/core/config/dependency/dependency_config.dart';
import 'package:sgas/core/ui/resource/icon_path.dart';
import 'package:sgas/core/ui/resource/image_path.dart';
import 'package:sgas/core/config/routes/route_path.dart';
import 'package:sgas/core/ui/style/base_color.dart';
import 'package:sgas/core/ui/style/base_text_style.dart';
import 'package:sgas/src/feature/authentication/presentation/bloc/authentication/authentication_cubit.dart';
import 'package:sgas/src/feature/authentication/presentation/bloc/login/login_cubit.dart';
import 'package:sgas/src/feature/authentication/presentation/widgets/label_textfield.dart';
import 'package:sgas/src/feature/authentication/presentation/widgets/error_message_text_field.dart';
import 'package:sgas/src/common/presentation/widget/button/button_primary.dart';
import 'package:sgas/src/common/presentation/widget/text_field/text_field_common.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _username = TextEditingController();
  final _password = TextEditingController();
  bool isHidden = true;
  bool isLoading = false;

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
        bloc: getIt.get<LoginCubit>(),
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: SizedBox.expand(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(
                    flex: 2,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Image.asset(ImagePath.logoTMA)),
                  const Spacer(
                    flex: 1,
                  ),
                  const LabelTextField(
                    title: 'Tên đăng nhập',
                  ),
                  TextFieldCommon(
                    hintText: "Nhập tên đăng nhập",
                    controller: _username,
                    error: (state is InValidUserName)
                        ? ErrorMessageTextField(
                            mess: state.message,
                          )
                        : null,
                  ),
                  const SizedBox(height: 16),
                  const LabelTextField(title: "Mật khẩu"),
                  TextFieldCommon(
                    hintText: "Nhập mật khẩu",
                    suffixIcon: IconButton(
                      highlightColor: const Color.fromRGBO(0, 0, 0, 0),
                      onPressed: () {
                        setState(() {
                          isHidden = !isHidden;
                        });
                      },
                      icon: SvgPicture.asset(
                        (isHidden)
                            ? IconPath.showPassword
                            : IconPath.hidePassword,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    isHidden: isHidden,
                    controller: _password,
                    error: (state is InValidPassWord)
                        ? ErrorMessageTextField(
                            mess: state.message,
                          )
                        : null,
                  ),
                  const _ForgetPasswordText(),
                  PrimaryButton(
                    isLoading: isLoading,
                    buttonTitle: "Đăng nhập",
                    onPress: () => handleButtonLogin(),
                  ),
                  const Spacer(
                    flex: 3,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> handleButtonLogin() async {
    setState(() {
      isLoading = true;
    });
    await getIt
        .get<AuthenticationCubit>()
        .login(_username.text, _password.text);
    setState(() {
      isLoading = false;
    });
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
        style: BaseTextStyle.body1(color: BaseColor.textPrimaryColor),
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
            style: BaseTextStyle.button1(color: BaseColor.primaryColor),
          ),
        ),
      ),
    );
  }
}
