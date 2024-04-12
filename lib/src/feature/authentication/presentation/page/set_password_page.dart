import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sgas/core/config/dependency/dependency_config.dart';
import 'package:sgas/core/ui/resource/icon_path.dart';
import 'package:sgas/generated/l10n.dart';
import 'package:sgas/src/feature/authentication/presentation/bloc/forget_password/set_password_cubit.dart';
import 'package:sgas/src/feature/authentication/presentation/bloc/forget_password/set_password_state.dart';
import 'package:sgas/src/feature/authentication/presentation/utils/regex_check_valid.dart';
import 'package:sgas/src/feature/authentication/presentation/widgets/label_textfield.dart';
import 'package:sgas/src/feature/authentication/presentation/widgets/password_validation_lists.dart';
import 'package:sgas/src/feature/authentication/presentation/widgets/error_message_textfield.dart';
import 'package:sgas/src/common/presentation/widget/button/button_primary.dart';
import 'package:sgas/src/common/presentation/widget/text_field/text_field_common.dart';

class ValidationStatus {
  static const String valid = "ok";
  static const String inValid = "notOk";
}

class SetPasswordPage extends StatefulWidget {
  const SetPasswordPage({super.key, required this.data});
  final Map<String, String> data;

  @override
  State<SetPasswordPage> createState() => _SetPasswordPageState();
}

class _SetPasswordPageState extends State<SetPasswordPage> {
  final _passwordController = TextEditingController();
  final _rePasswordController = TextEditingController();
  List<Map<String, String>> validationLists = [
    {
      "title": S.current.txt_password_min_length,
      "status": ValidationStatus.inValid
    },
    {
      "title": S.current.txt_password_contains_letter,
      "status": ValidationStatus.inValid
    },
    {
      "title": S.current.txt_password_contains_digit,
      "status": ValidationStatus.inValid
    },
  ];
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
        title: Text(S.current.txt_change_password),
      ),
      body: BlocBuilder<SetPasswordCubit, SetPasswordState>(
        bloc: getIt.get<SetPasswordCubit>(),
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
                    LabelTextField(title: S.current.txt_password),
                    TextFieldCommon(
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
                    
                    LabelTextField(title: S.current.txt_confirm_password),
                    TextFieldCommon(
                      onChange: (value) {
                        getIt
                            .get<SetPasswordCubit>()
                            .changeState(InitialChangePassWord());
                      },
                      controller: _rePasswordController,
                      hintText: S.current.txt_re_enter_password,
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
                        buttonTitle: S.current.btn_confirm,
                        onPress: () async {
                          getIt.get<SetPasswordCubit>().updatePass(
                              token: widget.data["data"]!,
                              password: _passwordController.text,
                              rePassword: _rePasswordController.text,
                              username: widget.data["username"]!);
                        },
                      )
                    else
                      PrimaryButton(
                        buttonTitle: S.current.btn_confirm,
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
