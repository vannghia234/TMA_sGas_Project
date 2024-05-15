import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sgas/core/ui/resource/image_path.dart';
import 'package:sgas/src/common/util/constant/screen_size_constaint.dart';

class AppLoadingPage extends StatelessWidget {
  const AppLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth >= ScreenSizeConstant.minTabletWidth) {
            return Center(
                child: Lottie.asset(ImagePath.dotLoading,
                    fit: BoxFit.cover, width: 134, height: 150));
          }
          return Center(
              child: Lottie.asset(ImagePath.dotLoading,
                  fit: BoxFit.cover, width: 84, height: 94));
        }));
  }
}
