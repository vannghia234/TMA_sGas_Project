import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgas/core/config/dependency/dependency_config.dart';
import 'package:sgas/core/ui/style/base_color.dart';
import 'package:sgas/core/ui/style/base_text_style.dart';
import 'package:sgas/generated/l10n.dart';
import 'package:sgas/src/common/utils/constant/screen_size_constant.dart';
import 'package:sgas/src/feature/authentication/presentation/bloc/forget_password/otp_cubit.dart';
import 'package:sgas/src/feature/authentication/presentation/bloc/forget_password/otp_state.dart';
import 'package:timer_count_down/timer_count_down.dart';

class AlertMessageOTP extends StatelessWidget {
  const AlertMessageOTP({super.key});
  final int countDownTime = 120;
  Widget timerCountDown(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > ScreenSizeConstant.maxTabletWidth) {
        return Align(
          alignment: Alignment.center,
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OtpCubit, OtpState>(
      bloc: getIt.get<OtpCubit>(),
      builder: (context, state) {
        if (state is TimeOutOtp) {
          return AlertMessage(
            color: BaseColor.red500,
            title: S.current.txt_otp_expired,
          );
        }
        if (state is WaitingOtp) {
          return timerCountDown(context);
        }
        return timerCountDown(context);
      },
    );
  }
}

class AlertMessage extends StatelessWidget {
  const AlertMessage({
    super.key,
    this.color,
    this.title,
  });
  final Color? color;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > ScreenSizeConstant.maxTabletWidth) {
        return Align(
          alignment: Alignment.center,
          child: Text(
            title ?? "",
            style: BaseTextStyle.body2(color: color),
          ),
        );
      }
      return Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title ?? "",
          style: BaseTextStyle.body2(color: color),
        ),
      );
    });
  }
}
