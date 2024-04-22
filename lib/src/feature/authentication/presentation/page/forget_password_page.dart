import 'package:flutter/material.dart';
import 'package:sgas/core/ui/style/base_text_style.dart';
import 'package:sgas/generated/l10n.dart';
import 'package:sgas/src/common/utils/controller/layout_controller.dart';
import 'package:sgas/src/feature/authentication/presentation/widgets/forget_form.dart';
import 'package:sgas/src/feature/authentication/presentation/widgets/notification_header.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final _username = TextEditingController();
  final _phoneNumber = TextEditingController();

  @override
  void dispose() {
    _username.dispose();
    _phoneNumber.dispose();
    super.dispose();
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
        title: Text(
          S.current.txt_confirm_password,
        ),
      ),
      body: Column(
        children: [
          isMobileLayout()
              ? Column(
                  children: [
                    NotificationHeader(
                      title: S.current.txt_instructions,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                  ],
                )
              : Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        S.current.txt_instructions,
                        style: BaseTextStyle.body1(),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
          ForgetForm(username: _username, phoneNumber: _phoneNumber),
          const Spacer(
            flex: 2,
          )
        ],
      ),
    );
  }
}
