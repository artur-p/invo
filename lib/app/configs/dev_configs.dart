import 'package:injectable/injectable.dart';
import 'package:invo_app/app/configs/base_configs.dart';

@dev
@Injectable(as: BaseConfigs)
class DevConfigs extends BaseConfigs {
  ///TODO(Artur): Use dart define or envied package to store this data
  @override
  String get baseUrl => 'https://testapi.pl/be/api/';

  @override
  int get connectTimeout => 30000;

  @override
  int get receiveTimeout => 30000;

  @override
  String get identifier => 'dev_environment';

  @override
  Uri get privacyUri => Uri.parse('https://google.com');

  @override
  Uri get termsUri => Uri.parse('https://google.com');

  @override
  List<String> get certificatePems => [];

  @override
  String get apkCertificateSha256 => '';

  @override
  bool get isDebugEnvironment => true;
}
