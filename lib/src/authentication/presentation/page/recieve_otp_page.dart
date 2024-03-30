import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgas/core/helper/logger_helper.dart';
import 'package:sgas/core/helper/screen_helper.dart';
import 'package:sgas/core/config/routes/route_path.dart';
import 'package:sgas/core/ui/style/base_color.dart';
import 'package:sgas/core/ui/style/base_style.dart';
import 'package:sgas/src/authentication/presentation/bloc/otp_cubit.dart';
import 'package:sgas/src/authentication/presentation/bloc/otp_state.dart';
import 'package:sgas/src/authentication/presentation/utils/hide_sdt.dart';
import 'package:sgas/src/common/presentation/widget/button/button_primary.dart';
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
  int countDownTime = 60;

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

  void clearOtp() {
    for (var element in controllers) {
      element.clear();
    }
    focusNodes[0].requestFocus();
    otp = "";
  }

  void updateOtp() {
    otp = "";
    for (var i = 0; i < controllers.length; i++) {
      if (controllers[i].text == "") {
        otp += "_";
        continue;
      }
      otp += controllers[i].text;
    }
    logger.f("OTP cuối $otp");
  }

  Future<void> _sendOTP(BuildContext context) async {
    Map<String, String> data =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    logger.e("Test ${data["phone"]!}");
    logger.f("Mã otp $otp");

    var res = await context
        .read<OtpCubit>()
        .sendOtp(userName: data["userName"]!, otpCode: otp);
    clearOtp();
    if (res.code == 200) {
      // context.read<OtpCubit>().changeState(InitialOtp());
      Map<String, String> arg = {
        "data": res.data!,
        "username": data["userName"]!
      };

      Navigator.popAndPushNamed(context, RoutePath.changNewPassword,
          arguments: arg);
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
        titleTextStyle: BaseTextStyle.label2(color: BaseColor.textPrimaryColor),
      ),
      body: SizedBox.expand(
        child: Column(
          children: [
            _OtpMemoTitle(data: data),
            const SizedBox(height: 24),
            _otpFormField(context),
          ],
        ),
      ),
    );
  }

  Padding _otpFormField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getWidthScreen(context) * 0.05),
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
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        controller: controllers[index],
                        focusNode: focusNodes[index],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        onChanged: (value) {
                          updateOtp();
                          if (value.isNotEmpty) {
                            // setState(() {
                            //   otp += value;
                            // });

                            if (index < controllers.length - 1) {
                              FocusScope.of(context)
                                  .requestFocus(focusNodes[index + 1]);
                            } else {
                              _sendOTP(context);
                            }
                          } else if (value.isEmpty) {
                            // otp = removeCharAtIndex(otp, index);
                            // logger.e("OTP sau xóa $otp");
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
                                  color: BaseColor.borderColor, width: 1),
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
                        style: BaseTextStyle.body2(),
                      ),
                    )
                  : (state is IncorrectOtp)
                      ? Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Mã OTP không chính xác",
                            style: BaseTextStyle.body2()
                                .copyWith(color: Colors.red),
                          ),
                        )
                      : (state is OverRequestOtp)
                          ? Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                state.mess,
                                style: BaseTextStyle.body2()
                                    .copyWith(color: Colors.red),
                              ),
                            )
                          : (state is WaittingOtp)
                              ? _timerCountDown(context)
                              : (state is InitialOtp)
                                  ? _timerCountDown(context)
                                  : const SizedBox();
            },
          ),
          // Text(
          //   'Mã OTP sẽ hết hạn sau 1:20 phút',
          //   style: BaseTextStyle.body2(),
          // ),
          const SizedBox(height: 24),
          BlocBuilder<OtpCubit, OtpState>(
            builder: (context, state) {
              return (state is WaittingOtp)
                  ? PrimaryButton(
                      buttonTitle: "Xác nhận",
                      onPress: () {
                        // context.read<OtpCubit>().changeState(SentOtp());
                      },
                    )
                  : PrimaryButton(
                      buttonTitle: "Gửi lại mã OTP",
                      onPress: () {
                        Map<String, String> data = ModalRoute.of(context)!
                            .settings
                            .arguments as Map<String, String>;

                        context.read<OtpCubit>().reSendOtp(
                            userName: data["userName"]!, phone: data["phone"]!);
                      },
                    );
            },
          ),
        ],
      ),
    );
  }

  Align _timerCountDown(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Countdown(
        seconds: countDownTime,
        build: (BuildContext context, double time) => RichText(
          text: TextSpan(
              style: BaseTextStyle.body2(),
              text: "Mã OTP của bạn sẽ hết hạn sau ",
              children: [
                TextSpan(
                    text: "${time.toInt()}s",
                    style: BaseTextStyle.body2().copyWith(
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

class _OtpMemoTitle extends StatelessWidget {
  const _OtpMemoTitle({
    super.key,
    required this.data,
  });

  final Map<String, String> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: BaseColor.backgroundNeutralColor,
      padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 15),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'Mã OTP đã được gửi về số điện thoại ',
          style: BaseTextStyle.body2(color: BaseColor.textSecondaryColor),
          children: <InlineSpan>[
            TextSpan(
              text: hideSDT(data["phone"]!),
              style: BaseTextStyle.body2(color: BaseColor.textPrimaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
