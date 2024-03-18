import 'package:avatar_brick/avatar_brick.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sgas/core/constants/icon_path.dart';
import 'package:sgas/core/utils/custom_color.dart';
import 'package:sgas/core/utils/custom_textstyle.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: CustomColor.textPrimaryColor,
          ),
        ),
        title: Text(
          'Cài đặt',
          style: CustomTextStyle.lable2(
            textColor: CustomColor.textPrimaryColor,
          ),
        ),
      ),
      body: Container(
        height: 440,
        color: CustomColor.backgroundNeutralColor,
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          children: [
            _userAvatar(),
            _customContainer(context, 'Tài khoản'),
          ],
        ),
      ),
    );
  }

  Widget _userAvatar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        height: 80,
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: AvatarBrick(
                size: Size(48, 48),
                backgroundColor: Colors.black26,
                icon: Icon(
                  Icons.person_rounded,
                  size: 35,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Admin',
                  style: CustomTextStyle.lable2(
                    textColor: CustomColor.textPrimaryColor,
                  ),
                ),
                const SizedBox(width: 2),
                Text(
                  'System admin',
                  style: CustomTextStyle.body3(
                    textColor: CustomColor.textSecondaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _customContainer(BuildContext context, String name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 8),
          child: Text(
            'Tài khoản',
            style: CustomTextStyle.lable3(textColor: CustomColor.textSecondaryColor),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              _customSettingButton(context),
              Container(
                height: 0,
                width: 310,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1.0,
                      color: CustomColor.borderNeutralColor,
                    ),
                  ),
                ),
              ),
              _customSettingButton(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _customSettingButton(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          // color: Colors.red,
          // borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
          ),
      child: TextButton(
        onPressed: () {
          print('a');
        },
        child: Row(
          children: [
            SvgPicture.asset(IconPath.person),
            Text(
              'Cập nhật thông tin',
              style: CustomTextStyle.body1(textColor: CustomColor.textPrimaryColor),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: CustomColor.textSecondaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
