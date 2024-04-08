import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sgas/core/config/dependency/dependency_config.dart';
import 'package:sgas/core/ui/resource/icon_path.dart';
import 'package:sgas/core/utils/helper/logger_helper.dart';
import 'package:sgas/src/authentication/presentation/bloc/forget_password/change_password_cubit.dart';
import 'package:sgas/src/authentication/presentation/bloc/forget_password/change_password_state.dart';
import 'package:sgas/src/authentication/presentation/utils/regex_check_valid.dart';
import 'package:sgas/src/authentication/presentation/widgets/label_textfield.dart';
import 'package:sgas/src/authentication/presentation/widgets/password_validation_lists.dart';
import 'package:sgas/src/authentication/presentation/widgets/error_message_text_field.dart';
import 'package:sgas/src/common/presentation/widget/button/button_primary.dart';
import 'package:sgas/src/common/presentation/widget/text_field/text_field_common.dart';

class ValidationStatus {
  static const String valid = "ok";
  static const String inValid = "notOk";
}

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key, required this.data});
  final Map<String, String> data;

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
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
  void initState() {
    logger.f(
        "debug changePass ${widget.data["username"]} ${widget.data["data"]}}");
    super.initState();
  }

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
        bloc: getIt.get<ChangePasswordCubit>(),
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
                    const LabelTextField(title: "Xác nhận mật khẩu"),
                    TextFieldCommon(
                      onChange: (value) {
                        getIt
                            .get<ChangePasswordCubit>()
                            .changeState(InitialChangePassWord());
                      },
                      controller: _rePasswordController,
                      hintText: "Nhập lại mật khẩu",
                      error: (state is InValidRePassword)
                          ? ErrorMessageTextField(
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
                    PasswordValidationLists(
                      lists: validationLists,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    if (_isAllValidList(validationLists))
                      PrimaryButton(
                        buttonTitle: "Xác nhận",
                        onPress: () async {
                          getIt.get<ChangePasswordCubit>().updatePass(
                              token: widget.data["data"]!,
                              password: _passwordController.text,
                              rePassword: _rePasswordController.text,
                              username: widget.data["username"]!);
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

  void _handleOnChange(String value) {
    return setState(() {
      if (value.length >= 8) {
        validationLists[0]["status"] = ValidationStatus.valid;
      } else {
        validationLists[0]["status"] = ValidationStatus.inValid;
      }
      if (atLeast1LetterExist(value)) {
        validationLists[1]["status"] = ValidationStatus.valid;
      } else {
        validationLists[1]["status"] = ValidationStatus.inValid;
      }

      if (atLeast1NumberExist(value)) {
        validationLists[2]["status"] = ValidationStatus.valid;
      } else {
        validationLists[2]["status"] = ValidationStatus.inValid;
      }
    });
  }
}
