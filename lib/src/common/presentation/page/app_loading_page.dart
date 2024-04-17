import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sgas/core/ui/resource/image_path.dart';

class AppLoadingPage extends StatelessWidget {
  const AppLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Lottie.asset(ImagePath.dotLoading,
              fit: BoxFit.cover, width: 84, height: 94)),
    );
  }
}
