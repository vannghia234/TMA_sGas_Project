import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sgas/core/ui/resource/icon_path.dart';
import 'package:sgas/core/helper/logger_helper.dart';
import 'package:sgas/core/config/routes/route_path.dart';
import 'package:sgas/src/authentication/presentation/bloc/change_password_cubit.dart';
import 'package:sgas/src/authentication/presentation/bloc/change_password_state.dart';
import 'package:sgas/src/authentication/presentation/utils/regex_check_valid.dart';
import 'package:sgas/src/authentication/presentation/widgets/label_textfield.dart';
import 'package:sgas/src/authentication/presentation/widgets/password_validation_widget.dart';
import 'package:sgas/src/authentication/presentation/widgets/text_field_error_message.dart';
import 'package:sgas/src/common/presentation/widget/button/button_primary.dart';
import 'package:sgas/src/common/presentation/widget/text_field/text_field_common.dart';

class ValidationStatus {
  static const String valid = "ok";
  static const String inValid = "notOk";
}

class ChangeNewPasswordPage extends StatefulWidget {
  const ChangeNewPasswordPage({super.key, required this.data});
  final Map<String, String> data;

  @override
  State<ChangeNewPasswordPage> createState() => _ChangeNewPasswordPageState();
}

class _ChangeNewPasswordPageState extends State<ChangeNewPasswordPage> {
  final _passwordController = TextEditingController();
  final _rePasswordController = TextEditingController();
  List<Map<String, String>> validationLists = [
    {"title": "Tối thiểu 8 ký tự", "status": ValidationStatus.inValid},
    {"title": "Chứa ít nhất 1 ký tự chữ", "status": ValidationStatus.inValid},
    {"title": "Chứa ít nhất một ký tự số", "status": ValidationStatus.inValid},
  ];
  bool isHiddenPassword = true;
  bool isHiddenRePassword = true;

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
  }

  bool _isAllValidList(List<Map<String, String>> lists) {
    for (var element in lists) {
      if (element["status"] == ValidationStatus.inValid) {
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: false,
        title: const Text('Đổi mật khẩu'),
      ),
      body: BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox.expand(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
                    const LabelTextField(title: "Mật khẩu"),
                    TextFieldCommon(
                      controller: _passwordController,
                      hintText: "Nhập mật khẩu",
                      isHidden: isHiddenPassword,
                      onChange: (value) {
                        setState(() {
                          if (value.length >= 8) {
                            validationLists[0]["status"] =
                                ValidationStatus.valid;
                          } else {
                            validationLists[0]["status"] =
                                ValidationStatus.inValid;
                          }
                          if (atLeast1LetterExist(value)) {
                            validationLists[1]["status"] =
                                ValidationStatus.valid;
                          } else {
                            validationLists[1]["status"] =
                                ValidationStatus.inValid;
                          }

                          if (atLeast1NumberExist(value)) {
                            validationLists[2]["status"] =
                                ValidationStatus.valid;
                          } else {
                            validationLists[2]["status"] =
                                ValidationStatus.inValid;
                          }
                        });
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
                    const LabelTextField(title: "Xác nhận mật khẩu"),
                    TextFieldCommon(
                      onChange: (value) {
                        context
                            .read<ChangePasswordCubit>()
                            .changeState(InitialChangePassWord());
                      },
                      controller: _rePasswordController,
                      hintText: "Nhập lại mật khẩu",
                      error: (state is InValidPassword)
                          ? TextFieldErrorMessage(
                              mess: state.message,
                            )
                          : null,
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
                    PasswordValidationWidget(
                      lists: validationLists,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    if (_isAllValidList(validationLists))
                      PrimaryButton(
                        buttonTitle: "Xác nhận",
                        onPress: () async {
                          if (_rePasswordController.text.isEmpty) {
                            context.read<ChangePasswordCubit>().changeState(
                                InValidPassword(
                                    message: "Vui lòng nhập lại mật khẩu"));
                            return;
                          }
                          if (_passwordController.text !=
                              _rePasswordController.text) {
                            context.read<ChangePasswordCubit>().changeState(
                                InValidPassword(
                                    message: "Mật khẩu không khớp"));
                            return;
                          } else {
                            // var res = await context
                            //     .read<ChangePasswordCubit>()
                            //     .updatePass(
                            //         token: widget.data["data"]!,
                            //         newPassword: _passwordController.text,
                            //         username: widget.data["username"]!);
                            // if (res.code == 200) {
                            //   logger.e("Đổi mật khẩu thành công ${res.data}");
                            //   Navigator.popAndPushNamed(
                            //       context, RoutePath.login);
                            // }
                          }
                        },
                      )
                    else
                      const PrimaryButton(
                        buttonTitle: "Xác nhận",
                      )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
