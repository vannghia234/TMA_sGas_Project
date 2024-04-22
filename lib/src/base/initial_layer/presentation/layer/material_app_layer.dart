import 'package:flutter/material.dart';
import 'package:sgas/core/config/route/route.dart';
import 'package:sgas/core/config/route/route_path.dart';
import 'package:sgas/core/ui/style/base_theme.dart';
import 'package:sgas/generated/l10n.dart';
import 'package:sgas/src/base/validation_layer/presentation/layer/validation_layer.dart';
import 'package:sgas/src/common/utils/constant/global_key.dart';

class MaterialAppLayer extends StatelessWidget {
  const MaterialAppLayer({super.key, this.locale});
  final Locale? locale;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: MaterialApp(
        onGenerateRoute: appRoute,
        initialRoute: RoutePath.root,
        navigatorKey: navigatorKey,
        scaffoldMessengerKey: scaffoldMessengerKey,
        theme: baseTheme(),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        locale: locale,
        home: const ValidationLayer(),
      ),
    );
  }
}
