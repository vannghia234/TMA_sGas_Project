import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgas/src/authentication/presentation/widgets/alert_message.dart';
import 'package:sgas/src/authentication/presentation/widgets/notification_header.dart';
import 'package:timer_count_down/timer_count_down.dart';

import 'package:sgas/core/config/routes/route_path.dart';
import 'package:sgas/core/utils/helper/logger_helper.dart';
import 'package:sgas/core/ui/style/base_color.dart';
import 'package:sgas/core/ui/style/base_style.dart';
import 'package:sgas/src/authentication/presentation/bloc/otp_cubit.dart';
import 'package:sgas/src/authentication/presentation/bloc/otp_state.dart';
import 'package:sgas/src/authentication/presentation/utils/hide_sdt.dart';
import 'package:sgas/src/common/presentation/widget/button/button_primary.dart';

class RecieveOTPPage extends StatefulWidget {
  const RecieveOTPPage({
    super.key,
    required this.userInfo,
  });
  final Map<String, String> userInfo;

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
    // var res = await context
    //     .read<OtpCubit>()
    //     .sendOtp(userName: widget.userInfo["username"]!, otpCode: otp);
    // clearOtp();
    // if (res.code == 200) {
    //   Map<String, String> arg = {
    //     "data": res.data!,
    //     "username": widget.userInfo["username"]!
    //   };

    //   Navigator.popAndPushNamed(context, RoutePath.ChangeNewPassword,
    //       arguments: arg);
    // }
    // Gửi mã OTP ở đây
  }

  @override
  Widget build(BuildContext context) {
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
            NotificationHeader(
              title:
                  "Mã OTP đã được gửi về số điện thoại ${hideSDT(widget.userInfo["phone"]!)}",
            ),
            const SizedBox(height: 24),
            _otpFormField(context),
          ],
        ),
      ),
    );
  }

  Padding _otpFormField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
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
                            if (index < controllers.length - 1) {
                              FocusScope.of(context)
                                  .requestFocus(focusNodes[index + 1]);
                            } else {
                              _sendOTP(context);
                            }
                          } else if (value.isEmpty) {
                            controllers[index].clear();
                            if (index > 0) {
                              FocusScope.of(context)
                                  .requestFocus(focusNodes[index - 1]);
                            }
                          }
                        },
                        decoration: InputDecoration(
                            counterText: '',
                            border: _outLineBorderCustom(),
                            focusedBorder: _outLineBorderCustom(),
                            enabledBorder: _outLineBorderCustom()),
                        cursorColor: BaseColor.textPrimaryColor,
                        cursorRadius: const Radius.circular(4),
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
              if (state is TimeOutOtp) {
                return const AlertMessage(
                  title: "Mã OTP của bạn đã hết hạn",
                  color: BaseColor.textPrimaryColor,
                );
              } else if (state is IncorrectOtp) {
                return const AlertMessage(
                  title: "Mã OTP không chính xác",
                );
              }
              if (state is OverRequestOtp) {
                return AlertMessage(title: state.mess);
              } else if (state is WaittingOtp) {
                return _timerCountDown(context);
              }
              return const SizedBox.shrink();
            },
          ),
          const SizedBox(height: 24),
          BlocBuilder<OtpCubit, OtpState>(
            builder: (context, state) {
              return (state is WaittingOtp)
                  ? PrimaryButton(
                      buttonTitle: "Xác nhận",
                      onPress: () {
                        _sendOTP(context);
                      },
                    )
                  : PrimaryButton(
                      buttonTitle: "Gửi lại mã OTP",
                      onPress: () {
                        context.read<OtpCubit>().reSendOtp(
                            userName: widget.userInfo["username"]!,
                            phone: widget.userInfo["phone"]!);
                      },
                    );
            },
          ),
        ],
      ),
    );
  }

  OutlineInputBorder _outLineBorderCustom() {
    return const OutlineInputBorder(
        borderSide: BorderSide(color: BaseColor.borderColor, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(8)));
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
