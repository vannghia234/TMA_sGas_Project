import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgas/core/config/dependency/dependency_config.dart';
import 'package:sgas/generated/l10n.dart';
import 'package:sgas/src/common/utils/controller/loading_controller.dart';
import 'package:sgas/src/feature/authentication/presentation/widgets/alert_message.dart';
import 'package:sgas/src/feature/authentication/presentation/widgets/notification_header.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:sgas/core/ui/style/base_color.dart';
import 'package:sgas/core/ui/style/base_text_style.dart';
import 'package:sgas/src/feature/authentication/presentation/bloc/forget_password/otp_cubit.dart';
import 'package:sgas/src/feature/authentication/presentation/bloc/forget_password/otp_state.dart';
import 'package:sgas/src/feature/authentication/presentation/utils/hide_phone_number.dart';
import 'package:sgas/src/common/presentation/widget/button/common_button.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({
    super.key,
    required this.userInfo,
  });
  final Map<String, String> userInfo;

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  List<TextEditingController> controllers =
      List.generate(6, (index) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());
  String otp = '';
  int countDownTime = 120;

  @override
  void initState() {
    getIt.get<OtpCubit>().changeState(InitialOtp());
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
      otp += controllers[i].text;
    }
  }

  Future<void> _sendOTP(BuildContext context) async {
    await getIt.get<OtpCubit>().sentOTP(
        username: widget.userInfo["username"]!, otp: otp, context: context);
    clearOtp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(S.current.txt_enter_otp),
      ),
      body: SizedBox.expand(
        child: Column(
          children: [
            NotificationHeader(
              title:
                  "${S.current.txt_otp_sent_to_phone} ${hidePhoneNumber(widget.userInfo["phone"]!)}",
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _otpFormField(context),
                  const SizedBox(height: 16),
                  BlocBuilder<OtpCubit, OtpState>(
                    bloc: getIt.get<OtpCubit>(),
                    builder: (context, state) {
                      if (state is TimeOutOtp) {
                        return AlertMessage(
                          color: BaseColor.red500,
                          title: S.current.txt_otp_expired,
                        );
                      }
                      if (state is WaitingOtp) {
                        return _timerCountDown(context);
                      }
                      if (state is InitialOtp) {
                        return _timerCountDown(context);
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  const SizedBox(height: 24),
                  BlocBuilder<OtpCubit, OtpState>(
                    bloc: getIt.get<OtpCubit>(),
                    builder: (context, state) {
                      return (state is TimeOutOtp)
                          ? CommonButton(
                              buttonTitle: S.current.btn_re_send_otp,
                              onPress: () async {
                                getIt<LoadingController>().start(context);
                                await getIt.get<OtpCubit>().reSendOtp(
                                    username: widget.userInfo["username"]!,
                                    phone: widget.userInfo["phone"]!);
                                // ignore: use_build_context_synchronously
                                getIt<LoadingController>().close(context);
                              },
                            )
                          : CommonButton(
                              buttonTitle: S.current.btn_confirm,
                              onPress: () async {
                                await _sendOTP(context);
                              },
                            );
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

  Widget _otpFormField(BuildContext context) {
    return FittedBox(
      child: SizedBox(
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
              text: "${S.current.txt_otp_expiry} ",
              children: [
                TextSpan(
                    text: "${time.toInt()}s",
                    style: BaseTextStyle.body2().copyWith(
                        color: Colors.red, fontWeight: FontWeight.bold)),
              ]),
        ),
        interval: const Duration(seconds: 1),
        onFinished: () {
          getIt.get<OtpCubit>().changeState(TimeOutOtp());
        },
      ),
    );
  }
}
