// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sgas/core/config/dependency/dependency_config.dart';
import 'package:sgas/core/ui/resource/icon_path.dart';
import 'package:sgas/core/ui/resource/image_path.dart';
import 'package:sgas/generated/l10n.dart';
import 'package:sgas/src/common/utils/controller/loading_controller.dart';
import 'package:sgas/src/feature/authentication/presentation/bloc/authentication/authentication_cubit.dart';
import 'package:sgas/src/feature/authentication/presentation/bloc/login/login_cubit.dart';
import 'package:sgas/src/common/presentation/widget/button/common_button.dart';
import 'package:sgas/src/common/presentation/widget/text_field/common_textfield.dart';
import 'package:sgas/src/feature/authentication/presentation/widgets/forget_text_button.dart';

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
                  TextFieldCommon(
                    label: S.current.txt_username,
                    hintText: S.current.txt_enter_username,
                    controller: _username,
                    messageError:
                        (state is InValidUserNameLogin) ? state.message : null,
                  ),
                  const SizedBox(height: 16),
                  TextFieldCommon(
                    label: S.current.txt_password,
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
                    messageError:
                        (state is InValidPassWordLogin) ? state.message : null,
                  ),
                  const ForgetTextButton(),
                  CommonButton(
                      isLoading: isLoading,
                      buttonTitle: S.current.btn_login,
                      onPress: () => handleButtonLogin()),
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
