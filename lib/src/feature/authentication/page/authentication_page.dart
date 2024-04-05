import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:sgas/core/ui/style/base_text_style.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Authentication page ",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontFamily: BaseTextStyle.baseFont),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
