class AppVersionModel {
  AppVersionModel(this.major, this.minor, this.patch);

  final int major;
  final int minor;
  final int patch;

  static AppVersionModel? toModule(String? version) {
    if (version == null || version.length > 8 || version.length < 5) {
      return null;
    }
    String pattern = r'^([0-9][0-9]?)\.([0-9][0-9]?)\.([0-9][0-9]?)$';
    RegExp versionRegExp = RegExp(pattern);
    if (!versionRegExp.hasMatch(version)) return null;
    final result = versionRegExp.firstMatch(version);
    if (result == null ||
        result.group(1) == null ||
        result.group(2) == null ||
        result.group(3) == null) return null;
    return AppVersionModel(
      int.parse(result.group(1)!),
      int.parse(result.group(2)!),
      int.parse(result.group(3)!),
    );
  }
}
