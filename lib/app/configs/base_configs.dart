abstract class BaseConfigs {
  String get baseUrl;
  int get connectTimeout;
  int get receiveTimeout;
  Uri get termsUri;
  Uri get privacyUri;

  List<String> get certificatePems;

  /// SHA-256 digest of the certificate used to sign the Android apk.
  ///
  /// Can be extracted with `apksigner verify --print-certs`.
  String get apkCertificateSha256;

  bool get isDebugEnvironment;
  String get identifier;
}
