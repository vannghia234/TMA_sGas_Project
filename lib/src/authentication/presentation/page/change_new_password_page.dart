import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sgas/core/ui/resource/image_path.dart';
import 'package:sgas/core/ui/style/base_color.dart';
import 'package:sgas/core/ui/style/base_style.dart';
import 'package:sgas/core/helper/logger_helper.dart';
import 'package:sgas/core/helper/screen_helper.dart';
import 'package:sgas/core/config/routes/route_path.dart';
import 'package:sgas/src/authentication/presentation/bloc/change_password_cubit.dart';
import 'package:sgas/src/authentication/presentation/bloc/change_password_state.dart';
import 'package:sgas/src/authentication/presentation/bloc/change_re_password_cubit.dart';
import 'package:sgas/src/authentication/presentation/widgets/text_field_password.dart';
import 'package:sgas/src/authentication/presentation/widgets/text_field_repassword.dart';
import 'package:sgas/src/common/presentation/widget/button/button_primary.dart';

class ChangeNewPasswordPage extends StatefulWidget {
  const ChangeNewPasswordPage({super.key});

  @override
  State<ChangeNewPasswordPage> createState() => _ChangeNewPasswordPageState();
}

class _ChangeNewPasswordPageState extends State<ChangeNewPasswordPage> {
  final _passwordController = TextEditingController();
  final _rePasswordController = TextEditingController();
  List<String> errorlists = [
    "Tối thiểu 8 ký tự",
    "Chứa ít nhất 1 ký tự chữ",
    "Chứa ít nhất một ký tự số"
  ];

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, String> data =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    logger.e(data.runtimeType);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);

            //
          },
        ),
        centerTitle: false,
        title: const Text('Đổi mật khẩu'),
      ),
      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getWidthScreen(context) * 0.05),
          child: Column(
            children: [
              SizedBox(
                height: getHeightScreen(context) * 0.05,
              ),
              TextFieldPassowrd(
                  controller: _passwordController,
                  title: "Mật khẩu",
                  hintText: "Nhập mật khẩu",
                  isObsuretext: true),
              SizedBox(
                height: getHeightScreen(context) * 0.02,
              ),
              TextFieldRePassword(
                  controller: _rePasswordController,
                  title: "Xác nhận mật khẩu",
                  hintText: "Nhập lại mật khẩu",
                  isObsuretext: true),
              SizedBox(
                height: getHeightScreen(context) * 0.03,
              ),
              Flexible(
                child: BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
                  builder: (context, state) => ListView.builder(
                    shrinkWrap: true,
                    itemCount: errorlists.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: (state is InValidPassword)
                          ? _ErrorMess(index, state)
                          : _ErrorMessDefault(index),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: getHeightScreen(context) * 0.03,
              ),
              //Button
              BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
                builder: (context, state) => PrimaryButton(
                  buttonTitle: "Xác nhận",
                  onPress: () async {
                    if (_passwordController.text !=
                        _rePasswordController.text) {
                      context.read<ChangeRepasswordCubit>().changeState(
                          InValidRePassword(message: "Mật khẩu không khớp"));
                    } else {
                      context
                          .read<ChangeRepasswordCubit>()
                          .changeState(SuccessValidPassword());
                      var res = await context
                          .read<ChangeRepasswordCubit>()
                          .updatePass(
                              token: data["data"]!,
                              newPassword: _rePasswordController.text,
                              username: data["username"]!);
                      if (res.code == 200) {
                        logger.e("Đổi mật khẩu thành công ${res.data}");
                        Navigator.pushNamed(context, RoutePath.login);
                      }
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Row _ErrorMessDefault(int index) {
    return Row(
      children: [
        SvgPicture.asset(
          ImagePath.checkCircle,
          height: 24,
          width: 24,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          errorlists[index],
          style: BaseTextStyle.body2(color: BaseColor.textSecondaryColor),
        )
      ],
    );
  }

  Row _ErrorMess(int index, InValidPassword state) {
    return Row(
      children: [
        if (index == 0 && state.isEnoughCharacter)
          SvgPicture.asset(
            ImagePath.fillCheckCircle,
            height: 24,
            width: 24,
          )
        else if (index == 1 && state.isContainLetter)
          SvgPicture.asset(
            ImagePath.fillCheckCircle,
            height: 24,
            width: 24,
          )
        else if (index == 2 && state.isContainNumber)
          SvgPicture.asset(
            ImagePath.fillCheckCircle,
            height: 24,
            width: 24,
          )
        else
          SvgPicture.asset(
            ImagePath.checkCircle,
            height: 24,
            width: 24,
          ),
        const SizedBox(
          width: 5,
        ),
        Text(
          errorlists[index],
          style: BaseTextStyle.body2(color: BaseColor.textSecondaryColor),
        )
      ],
    );
  }
}
