import 'package:sgas/core/service/client/local_service_client.dart';
import 'package:sgas/core/service/locator/shared_references_key.dart';

abstract class LocalDatasourceInterface {
  saveLanguageCode(String? languageCode);

  Future<String?> getLanguageCode();

  removeLanguageCode();
}

class LanguageDataSource implements LocalDatasourceInterface {
  @override
  saveLanguageCode(String? languageCode) async {
    if (languageCode == null) {
      await removeLanguageCode();
    } else {
      await LocalServiceClient.save(
          key: ShareReferenceKey.currentLanguageKey, value: languageCode);
    }
  }

  @override
  Future<String?> getLanguageCode() async {
    String? code =
        await LocalServiceClient.get(ShareReferenceKey.currentLanguageKey);
    return code;
  }

  @override
  removeLanguageCode() async {
    await LocalServiceClient.remove(ShareReferenceKey.currentLanguageKey);
  }
}
