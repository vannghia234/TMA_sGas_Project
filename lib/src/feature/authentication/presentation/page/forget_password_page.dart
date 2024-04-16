import 'package:flutter/material.dart';
import 'package:sgas/generated/l10n.dart';
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
          NotificationHeader(
            title: S.current.txt_instructions,
          ),
          ForgetForm(username: _username, phoneNumber: _phoneNumber),
        ],
      ),
    );
  }
}
