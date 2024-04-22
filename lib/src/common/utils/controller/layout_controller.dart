import 'package:sgas/core/config/dependency/dependency_config.dart';

enum ScreenMode { mobile, tablet }

class ScreenSizeConstant {
  static const double maxMobileWidth = 375;
  static const double maxTabletWidth = 744;
}

bool isMobileLayout() {
  return getIt.get<LayoutController>().screenMode == ScreenMode.mobile;
}

class LayoutController {
  ScreenMode screenMode = ScreenMode.mobile;

  void setScreenMode(double width) {
    if (width >= ScreenSizeConstant.maxTabletWidth) {
      screenMode = ScreenMode.tablet;
      return;
    }
    screenMode = ScreenMode.mobile;
  }
}
