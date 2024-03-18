import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgas/core/constants/constants.dart';
import 'package:sgas/core/utils/custom_color.dart';
import 'package:sgas/core/utils/custom_textstyle.dart';
import 'package:sgas/routes/route_path.dart';
import 'package:sgas/src/authentication/view/bloc/otp_cubit.dart';
import 'package:sgas/src/authentication/view/bloc/otp_state.dart';
import 'package:sgas/src/authentication/view/utils/hide_sdt.dart';
import 'package:sgas/src/authentication/view/utils/remove_charAt.dart';
import 'package:sgas/src/authentication/view/widgets/primary_button.dart';
import 'package:timer_count_down/timer_count_down.dart';

class RecieveOTPPage extends StatefulWidget {
  // final String userName;
  // final String phone;
  const RecieveOTPPage({
    super.key,
  });

  @override
  State<RecieveOTPPage> createState() => _RecieveOTPPageState();
}

class _RecieveOTPPageState extends State<RecieveOTPPage> {
  List<TextEditingController> controllers =
      List.generate(6, (index) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());
  String otp = '';

  @override
  void initState() {
    focusNodes[0].requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _sendOTP(BuildContext context) async {
    Map<String, String> data =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    logger.e("Test ${data["phone"]!}");
    showAnimationLoading(context);

    var res = await context
        .read<OtpCubit>()
        .sendOtp(userName: data["userName"]!, otpCode: otp);
    if (res.code == 200) {
      context.read<OtpCubit>().changeState(SuccessfulOtp());
      Map<String, String> arg = {
        "data": res.data!,
        "username": data["userName"]!
      };
      Navigator.pop(context);

      Navigator.pushNamed(context, RoutePath.changeNewPassword, arguments: arg);
    }
    // Gửi mã OTP ở đây
  }

  @override
  Widget build(BuildContext context) {
    Map<String, String> data =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text('Nhập mã OTP'),
        titleTextStyle:
            CustomTextStyle.lable2(textColor: CustomColor.textPrimaryColor),
      ),
      body: SizedBox.expand(
        child: Column(
          children: [
            Container(
              height: 72,
              color: CustomColor.backgroundNeutralColor,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              child: Text.rich(
                TextSpan(
                  text: 'Mã OTP đã được gửi về số điện thoại ',
                  style: CustomTextStyle.body2(
                      textColor: CustomColor.textSecondaryColor),
                  children: <InlineSpan>[
                    TextSpan(
                      text: hideSDT(data["phone"]!),
                      style: CustomTextStyle.body2(
                          textColor: CustomColor.textPrimaryColor),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getWidthScreen(context) * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 56,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            SizedBox(
                              height: 56,
                              width: 48,
                              child: TextField(
                                controller: controllers[index],
                                focusNode: focusNodes[index],
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                maxLength: 1,
                                onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    setState(() {
                                      otp += value;
                                    });
                                    if (index < controllers.length - 1) {
                                      FocusScope.of(context)
                                          .requestFocus(focusNodes[index + 1]);
                                    } else {
                                      _sendOTP(context);
                                    }
                                  } else {
                                    otp = removeCharAtIndex(otp, index);
                                    logger.e("OTP sau xóa $otp");

                                    controllers[index]
                                        .clear(); // Xóa giá trị trong ô TextField nếu giá trị rỗng

                                    if (index > 0) {
                                      // Di chuyển đến ô trước đó nếu giá trị rỗng và không phải là ô đầu tiên
                                      FocusScope.of(context)
                                          .requestFocus(focusNodes[index - 1]);
                                    }
                                  }
                                },
                                decoration: const InputDecoration(
                                  counterText: '',
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: CustomColor.borderNeutralColor,
                                          width: 1),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12.4)
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  BlocBuilder<OtpCubit, OtpState>(
                    builder: (context, state) {
                      return (state is TimeOutOtp)
                          ? Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Mã OTP của bạn đã hết hạn",
                                style: CustomTextStyle.body2(),
                              ),
                            )
                          : (state is IncorrectOtp)
                              ? Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Mã OTP không chính xác",
                                    style: CustomTextStyle.body2()
                                        .copyWith(color: Colors.red),
                                  ),
                                )
                              : (state is SuccessfulOtp)
                                  ? const SizedBox.shrink()
                                  : _timerCountDown(context);
                    },
                  ),
                  // Text(
                  //   'Mã OTP sẽ hết hạn sau 1:20 phút',
                  //   style: CustomTextStyle.body2(),
                  // ),
                  const SizedBox(height: 24),
                  BlocBuilder<OtpCubit, OtpState>(
                    builder: (context, state) {
                      return (state is SentOtp)
                          ? PrimaryButton(
                              text: "Xác nhận",
                              onpress: () {
                                context.read<OtpCubit>().changeState(SentOtp());
                              },
                              isDisable: false)
                          : PrimaryButton(
                              text: "Gửi lại mã OTP",
                              onpress: () {
                                Map<String, String> data =
                                    ModalRoute.of(context)!.settings.arguments
                                        as Map<String, String>;

                                context.read<OtpCubit>().reSendOtp(
                                    userName: data["userName"]!,
                                    phone: data["phone"]!);

                                context.read<OtpCubit>().changeState(SentOtp());
                              },
                              isDisable: false);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Align _timerCountDown(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Countdown(
        seconds: 60,
        build: (BuildContext context, double time) => RichText(
          text: TextSpan(
              style: CustomTextStyle.body2(),
              text: "Mã OTP của bạn sẽ hết hạn sau ",
              children: [
                TextSpan(
                    text: "${time.toInt()}s",
                    style: CustomTextStyle.body2().copyWith(
                        color: Colors.red, fontWeight: FontWeight.bold)),
              ]),
        ),
        interval: const Duration(seconds: 1),
        onFinished: () {
          context.read<OtpCubit>().changeState(TimeOutOtp());
          print('Timer is done!');
        },
      ),
    );
  }
}
