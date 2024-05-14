import 'package:flutter/material.dart';
import 'package:sgas/core/config/dependency/dependency_config.dart';
import 'package:sgas/core/ui/resource/image_path.dart';
import 'package:sgas/generated/l10n.dart';
import 'package:sgas/src/base/validation_layer/presentation/bloc/validation_cubit.dart';
import 'package:sgas/src/common/presentation/widget/exception/exception_widget.dart';
import 'package:sgas/src/common/utils/constant/screen_size_constaint.dart';

class DisconnectPage extends StatelessWidget {
  const DisconnectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: LayoutBuilder(builder: (context, constraints) {
            if (constraints.maxWidth >= ScreenSizeConstant.minTabletWidth) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ExceptionWidget(
                      onPress: () => getIt.get<ValidationCubit>().retry(),
                      imgPath: ImagePath.disconnect,
                      buttonTitle: S.current.btn_try_again,
                      subtitle: S.current.txt_check_network,
                      title: S.current.lbl_disconnect,
                    ),
                  ],
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ExceptionWidget(
                    onPress: () => getIt.get<ValidationCubit>().retry(),
                    imgPath: ImagePath.disconnect,
                    buttonTitle: S.current.btn_try_again,
                    subtitle: S.current.txt_check_network,
                    title: S.current.lbl_disconnect,
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
