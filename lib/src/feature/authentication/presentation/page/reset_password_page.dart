import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sgas/core/config/dependency/dependency_config.dart';
import 'package:sgas/core/config/route/route_path.dart';
import 'package:sgas/core/ui/resource/icon_path.dart';
import 'package:sgas/generated/l10n.dart';
import 'package:sgas/src/common/presentation/widget/button/common_button.dart';
import 'package:sgas/src/common/presentation/widget/validation/validate_password.dart';
import 'package:sgas/src/common/util/constant/screen_size_constant.dart';
import 'package:sgas/src/common/util/controller/loading_controller.dart';
import 'package:sgas/src/feature/authentication/presentation/bloc/forget_password/forget_password_controller.dart';
import 'package:sgas/src/feature/authentication/presentation/bloc/forget_password/forget_password_controller_state.dart';
import 'package:sgas/src/feature/authentication/presentation/bloc/forget_password/reset_password_cubit.dart';
import 'package:sgas/src/feature/authentication/presentation/bloc/forget_password/reset_password_state.dart';
import 'package:sgas/src/common/presentation/widget/text_field/common_textfield.dart';
import 'package:sgas/src/feature/authentication/presentation/page/login_page.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _passwordController = TextEditingController();
  final _rePasswordController = TextEditingController();
  bool isValidPassword = false;
  bool isHiddenPassword = true;
  bool isHiddenRePassword = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ),
              ModalRoute.withName(RoutePath.login),
            );
            getIt.get<ForgetControllerCubit>().changeState(ForgetScreenState());
          },
        ),
        title: Text(S.current.txt_change_password),
      ),
      body: SafeArea(
        child: SizedBox.expand(
          child: LayoutBuilder(builder: (context, constraints) {
            if (constraints.maxWidth > ScreenSizeConstant.maxTabletWidth) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(flex: 2),
                  SizedBox(
                      width: constraints.maxWidth * 2 / 3,
                      child: _resetPasswordForm(constraints, context)),
                  const Spacer(
                    flex: 5,
                  )
                ],
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  _resetPasswordForm(constraints, context)
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _resetPasswordForm(BoxConstraints constraints, BuildContext context) {
    return BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
      bloc: getIt.get<ResetPasswordCubit>(),
      builder: (context, state) {
        return Column(
          children: [
            TextFieldCommon(
              label: S.current.txt_password,
              controller: _passwordController,
              hintText: S.current.txt_enter_password,
              isHidden: isHiddenPassword,
              onChange: (value) {
                _handleOnChange(value);
              },
              suffixIcon: IconButton(
                highlightColor: Colors.transparent,
                onPressed: () {
                  setState(() {
                    isHiddenPassword = !isHiddenPassword;
                  });
                },
                icon: SvgPicture.asset(
                  (isHiddenPassword)
                      ? IconPath.showPassword
                      : IconPath.hidePassword,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextFieldCommon(
              label: S.current.txt_confirm_password,
              onChange: (value) {
                getIt
                    .get<ResetPasswordCubit>()
                    .changeState(InitialResetPassWord());
              },
              controller: _rePasswordController,
              hintText: S.current.txt_re_enter_password,
              messageError:
                  (state is InValidReEnterPassword) ? state.message : null,
              isHidden: isHiddenRePassword,
              suffixIcon: IconButton(
                highlightColor: Colors.transparent,
                onPressed: () {
                  setState(() {
                    isHiddenRePassword = !isHiddenRePassword;
                  });
                },
                icon: SvgPicture.asset(
                  (isHiddenRePassword)
                      ? IconPath.showPassword
                      : IconPath.hidePassword,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            ValidatePassword(isValidPassword: isValidPassword),
            const SizedBox(
              height: 24,
            ),
            CommonButton(
              buttonTitle: S.current.btn_confirm,
              onPress: (isValidPassword)
                  ? () async {
                      getIt<LoadingController>().start(context);
                      getIt
                          .get<ForgetControllerCubit>()
                          .resetPassword(_passwordController.text,
                              _rePasswordController.text)
                          .whenComplete(() {
                        getIt<LoadingController>().close(context);
                        getIt<ForgetControllerCubit>()
                            .changeState(ForgetScreenState());
                        Navigator.of(context)
                            .pushNamed(RoutePath.authentication);
                      });
                    }
                  : null,
            ),
          ],
        );
      },
    );
  }

  void _handleOnChange(String value) {
    if (value.length < 8) {
      setState(() {
        isValidPassword = false;
      });
    } else {
      setState(() {
        isValidPassword = true;
      });
    }
  }
}
