class APIPathModel {
  final String serviceHost;
  final String endpoint;
  final Map<String, String>? params;

  APIPathModel(
      {required this.serviceHost, required this.endpoint, this.params});
  String toStringPath() {
    String path = serviceHost;
    path += endpoint;
    if (params != null) {
      if (params!.isNotEmpty) {
        path += "?";
        params!.forEach((key, value) {
          path += "&$key=$value";
        });
      }
    }
    return path;
  }
}
