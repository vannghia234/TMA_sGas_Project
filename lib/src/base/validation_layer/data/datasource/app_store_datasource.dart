import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class AppStoreDataSourceInterface {
  Future<Either<Exception, void>> goToStore();
}

class AppStoreDataSource extends AppStoreDataSourceInterface {
  @override
  Future<Either<Exception, void>> goToStore() async {
    if (Platform.isIOS) {
      var url = 'https://apps.apple.com/app/6480381233';
      var uri = Uri.parse(url);
      if (!await launchUrl(uri)) {
        return Left(Exception());
      }
    }
    if (Platform.isAndroid) {
      var url =
          'https://play.google.com/store/apps/details?id=com.congson.sgas';
      var uri = Uri.parse(url);
      if (!await launchUrl(uri)) {
        return Left(Exception());
      }
    }
    return const Right(null);
  }
}
