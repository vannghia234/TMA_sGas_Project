import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sgas/core/ui/resource/image_path.dart';
import 'package:sgas/generated/l10n.dart';
import 'package:sgas/src/base/validation_layer/presentation/bloc/validation_cubit.dart';
import 'package:sgas/src/common/presentation/widget/exception/exception_widget.dart';
import 'package:sgas/src/common/utils/constant/screen_size_constaint.dart';

class DataParsingPage extends StatelessWidget {
  const DataParsingPage({super.key});

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
                      onPress: () {
                        GetIt.instance.get<ValidationCubit>().retry();
                      },
                      imgPath: ImagePath.errorVersion,
                      buttonTitle: S.current.btn_try_again,
                      subtitle: S.current.txt_try_again,
                      title: S.current.lbl_error_version,
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
                    onPress: () {
                      GetIt.instance.get<ValidationCubit>().retry();
                    },
                    imgPath: ImagePath.errorVersion,
                    buttonTitle: S.current.btn_try_again,
                    subtitle: S.current.txt_try_again,
                    title: S.current.lbl_error_version,
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
