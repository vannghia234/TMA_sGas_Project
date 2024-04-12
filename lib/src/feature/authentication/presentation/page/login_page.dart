import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sgas/core/config/dependency/dependency_config.dart';
import 'package:sgas/core/ui/resource/icon_path.dart';
import 'package:sgas/core/ui/resource/image_path.dart';
import 'package:sgas/core/config/route/route_path.dart';
import 'package:sgas/core/ui/style/base_color.dart';
import 'package:sgas/core/ui/style/base_text_style.dart';
import 'package:sgas/generated/l10n.dart';
import 'package:sgas/src/common/utils/controller/debounce_controller.dart';
import 'package:sgas/src/common/utils/controller/loading_controller.dart';
import 'package:sgas/src/feature/authentication/presentation/bloc/authentication/authentication_cubit.dart';
import 'package:sgas/src/feature/authentication/presentation/bloc/login/login_cubit.dart';
import 'package:sgas/src/feature/authentication/presentation/widgets/label_textfield.dart';
import 'package:sgas/src/feature/authentication/presentation/widgets/error_message_textfield.dart';
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
                  LabelTextField(
                    title: S.current.txt_username,
                  ),
                  TextFieldCommon(
                    hintText: S.current.txt_enter_username,
                    controller: _username,
                    error: (state is InValidUserName)
                        ? ErrorMessageTextField(
                            mess: state.message,
                          )
                        : null,
                  ),
                  const SizedBox(height: 16),
                  LabelTextField(title: S.current.txt_password),
                  TextFieldCommon(
                    hintText: S.current.txt_enter_password,
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
                    buttonTitle: S.current.btn_login,
                    onPress: () => getIt.get<DebounceController>().start(
                      function: () {
                        handleButtonLogin();
                      },
                    ),
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
    getIt.get<LoadingController>().start(context);
    await getIt
        .get<AuthenticationCubit>()
        .login(_username.text, _password.text);
    getIt.get<LoadingController>().close(context);
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
        S.current.txt_login,
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
            S.current.lbl_forget_pass,
            style: BaseTextStyle.button1(color: BaseColor.primaryColor),
          ),
        ),
      ),
    );
  }
}
