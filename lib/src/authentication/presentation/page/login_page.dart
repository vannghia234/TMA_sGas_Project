import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sgas/core/ui/resource/icon_path.dart';
import 'package:sgas/core/ui/resource/image_path.dart';
import 'package:sgas/core/config/routes/route_path.dart';
import 'package:sgas/core/ui/style/base_color.dart';
import 'package:sgas/core/ui/style/base_style.dart';
import 'package:sgas/src/authentication/domain/entities/authentication_entity.dart';
import 'package:sgas/src/authentication/domain/usecases/authenticaion_usecase.dart';
import 'package:sgas/src/authentication/presentation/bloc/login_cubit.dart';
import 'package:sgas/src/authentication/presentation/utils/key_storage.dart';
import 'package:sgas/src/authentication/presentation/widgets/label_textfield.dart';
import 'package:sgas/src/authentication/presentation/widgets/text_field_error_message.dart';
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
                        ? TextFieldErrorMessage(
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
                        ? TextFieldErrorMessage(
                            mess: state.message,
                          )
                        : null,
                  ),
                  const _ForgetPasswordText(),
                  PrimaryButton(
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
    if (_username.text.isEmpty) {
      context
          .read<LoginCubit>()
          .changeState(InValidUserName(message: "Bạn chưa nhập tên đăng nhập"));
      return;
    } else if (_password.text.isEmpty) {
      context
          .read<LoginCubit>()
          .changeState(InValidPassWord(message: "Bạn chưa nhập mật khẩu"));
      return;
    } else {
      AuthenticationUseCase authUseCase = AuthenticationUseCase();

      context.read<LoginCubit>().changeState(Successful());
      AuthenticationEntity entity = AuthenticationEntity(
          username: _username.text, password: _password.text);
      var res = await authUseCase.loginUseCase(entity);
      if (res.code == 200) {
        KeyStorage storage = KeyStorage();
        storage.save(
            accessToken: res.data!.token!.accessToken!,
            refreshToken: res.data!.token!.accessToken!);
        // Navigator.pushNamed(context, RoutePath.home);
      } else if (res.code == 40001) {
        context.read<LoginCubit>().changeState(
            InValidPassWord(message: "Sai tên đăng nhập hoặc mật khẩu"));
      } else if (res.code == 40002) {
        context
            .read<LoginCubit>()
            .changeState(InValidPassWord(message: "Tài khoản đã bị khóa"));
      } else if (res.code == 40003) {
        context.read<LoginCubit>().changeState(
            InValidPassWord(message: "Tài khoản của công ty bị khóa"));
      } else if (res.code == 40005) {
        context.read<LoginCubit>().changeState(InValidPassWord(
            message: "Tên tài khoản chỉ chứa kí tự a-z, A-Z, hoặc 0-9"));
      } else if (res.code == 40006) {
        context.read<LoginCubit>().changeState(
            InValidPassWord(message: "Tên tài khoản phải từ 8-50 kí tự"));
      } else if (res.code == 40007) {
        context.read<LoginCubit>().changeState(
            InValidPassWord(message: "Mật khẩu phải từ 8-50 kí tự"));
      }
    }
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
