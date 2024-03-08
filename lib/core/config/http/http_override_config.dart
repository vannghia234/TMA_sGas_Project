import 'dart:io';

/// This class overrides the "createHttpClient" method of the "HttpOverrides" class and sets a new "badCertificateCallback" function that accepts all SSL certificates.
class CustomHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
