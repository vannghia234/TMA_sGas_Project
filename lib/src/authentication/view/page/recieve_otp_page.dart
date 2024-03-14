import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sgas/core/utils/custom_color.dart';
import 'package:sgas/core/utils/custom_textstyle.dart';
import 'package:sgas/routes/route_path.dart';

class RecieveOTPPage extends StatefulWidget {
  const RecieveOTPPage({super.key});

  @override
  State<RecieveOTPPage> createState() => _RecieveOTPPageState();
}

class _RecieveOTPPageState extends State<RecieveOTPPage> {
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
        title: const Text('Nhận mã OTP'),
        titleTextStyle:
            CustomTextStyle.lable2(textColor: CustomColor.textPrimaryColor),
      ),
      body: Column(
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
                    text: '012*****89',
                    style: CustomTextStyle.body2(
                        textColor: CustomColor.textPrimaryColor),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            height: 168,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                          Container(
                            height: 56,
                            width: 48,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              // color: Colors.amberAccent,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                  color: CustomColor.borderNeutralColor,
                                  width: 1),
                            ),
                            child: const TextField(),
                          ),
                          const SizedBox(width: 12.4)
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Mã OTP sẽ hết hạn sau 1:20 phút',
                  style: CustomTextStyle.body2(),
                ),
                const SizedBox(height: 24),
                Container(
                  height: 48,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: CustomColor.primaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RoutePath.changeNewPassword);
                    },
                    child: Text(
                      'Xác nhận',
                      style: CustomTextStyle.button1(textColor: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
