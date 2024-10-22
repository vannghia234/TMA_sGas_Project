// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sgas/core/config/dependency/dependency_config.dart';
import 'package:sgas/core/config/route/route_path.dart';
import 'package:sgas/core/ui/resource/icon_path.dart';
import 'package:sgas/core/ui/resource/image_path.dart';
import 'package:sgas/core/ui/style/base_color.dart';
import 'package:sgas/core/ui/style/base_text_style.dart';
import 'package:sgas/generated/l10n.dart';
import 'package:sgas/src/common/presentation/widget/text_field/common_text_field.dart';
import 'package:sgas/src/common/util/constant/screen_size_constaint.dart';
import 'package:sgas/src/common/util/controller/loading_controller.dart';
import 'package:sgas/src/feature/authentication/presentation/bloc/authentication/authentication_cubit.dart';
import 'package:sgas/src/feature/authentication/presentation/bloc/login/login_cubit.dart';
import 'package:sgas/src/common/presentation/widget/button/common_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
      body: SizedBox.expand(
        child: LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth > ScreenSizeConstant.minTabletWidth) {
            return Column(
              children: [
                const Spacer(
                  flex: 3,
                ),
                SizedBox(
                    width: constraints.maxWidth * 2 / 3,
                    child: _loginForm(constraints, const Size(156, 80))),
                const Spacer(
                  flex: 4,
                ),
              ],
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(
                  flex: 1,
                ),
                _loginForm(constraints, const Size(109, 56)),
                const Spacer(
                  flex: 3,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _loginForm(BoxConstraints constraints, Size imgSize) {
    return BlocBuilder<LoginCubit, LoginState>(
      bloc: getIt.get<LoginCubit>(),
      builder: (context, state) {
        return Column(
          children: [
            Align(
                alignment: Alignment.center,
                child: Image.asset(
                  ImagePath.logoTMA,
                  width: imgSize.width,
                  height: imgSize.height,
                  fit: BoxFit.cover,
                )),
            const SizedBox(
              height: 80,
            ),
            CommonTextField(
              label: S.current.txt_username,
              hintText: S.current.txt_enter_username,
              controller: _username,
              messageError:
                  (state is InValidUserNameLogin) ? state.message : null,
            ),
            const SizedBox(height: 16),
            CommonTextField(
              label: S.current.txt_password,
              hintText: S.current.txt_enter_password,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    isHidden = !isHidden;
                  });
                },
                icon: SvgPicture.asset(
                  (isHidden) ? IconPath.showPassword : IconPath.hidePassword,
                  fit: BoxFit.scaleDown,
                ),
              ),
              isHidden: isHidden,
              controller: _password,
              messageError:
                  (state is InValidPassWordLogin) ? state.message : null,
            ),
            _textButton(context),
            CommonButton(
                text: S.current.btn_login, onPress: () => handleButtonLogin())
          ],
        );
      },
    );
  }

  Padding _textButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 24),
      child: Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, RoutePath.forgetPasswordLayer);
          },
          child: Text(
            S.current.lbl_forget_pass,
            style: BaseTextStyle.button1(color: BaseColor.primaryColor),
          ),
        ),
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
