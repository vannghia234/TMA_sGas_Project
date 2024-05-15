import 'package:flutter/material.dart';
import 'package:sgas/core/ui/resource/image_path.dart';
import 'package:sgas/core/ui/style/base_color.dart';
import 'package:sgas/core/ui/style/base_text_style.dart';
import 'package:sgas/generated/l10n.dart';
import 'package:sgas/src/base/validation_layer/domain/usecase/app_store_usecase.dart';
import 'package:sgas/src/common/presentation/widget/exception/exception_widget.dart';
import 'package:sgas/src/common/util/constant/screen_size_constaint.dart';
import 'package:sgas/src/common/util/controller/debounce_controller.dart';

class UnSupportVersionPage extends StatelessWidget {
  const UnSupportVersionPage({super.key, required this.appVersion});

  final String appVersion;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth >= ScreenSizeConstant.minTabletWidth) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ExceptionWidget(
                        onPress: () {
                          DebounceController()
                              .start(function: () => _gotoStore(context));
                        },
                        titleWidget: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              style: BaseTextStyle.h5(),
                              text: S.current.txt_version,
                              children: [
                                TextSpan(
                                    text: " $appVersion ",
                                    style: BaseTextStyle.h5(
                                        color: BaseColor.primaryColor)),
                                TextSpan(
                                  text: S.current.txt_no_support,
                                )
                              ]),
                        ),
                        imgPath: ImagePath.unSupportVersion,
                        buttonTitle: S.current.btn_update,
                        subtitle: S.current.txt_update_version,
                        title: S.current.txt_no_support,
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
                        DebounceController()
                            .start(function: () => _gotoStore(context));
                      },
                      titleWidget: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            style: BaseTextStyle.button1(),
                            text: S.current.txt_version,
                            children: [
                              TextSpan(
                                  text: " $appVersion ",
                                  style: BaseTextStyle.button1(
                                      color: BaseColor.primaryColor)),
                              TextSpan(
                                text: S.current.txt_no_support,
                              )
                            ]),
                      ),
                      imgPath: ImagePath.unSupportVersion,
                      buttonTitle: S.current.btn_update,
                      subtitle: S.current.txt_update_version,
                      title: S.current.txt_no_support,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  _gotoStore(BuildContext context) async {
    AppStoreUseCase().goToStore().then((value) {
      if (value.isRight) return;
    });
  }
}
