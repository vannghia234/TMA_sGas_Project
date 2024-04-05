import 'package:flutter/material.dart';
import 'package:sgas/core/config/route/route_path.dart';
import 'package:sgas/src/base/initial_layer/presentation/layer/initial_layer.dart';
import 'package:sgas/src/common/presentation/page/not_found_page.dart';

Route<dynamic> appRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case RoutePath.root:
      return MaterialPageRoute(
        builder: (_) => const InitialLayer(),
      );

    default:
      return MaterialPageRoute(builder: (_) => const NotFoundPage());
  }
}
