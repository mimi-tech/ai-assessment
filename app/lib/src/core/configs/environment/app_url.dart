import 'package:ai_assessment/src/core/configs/environment/environment_config.dart';

class AppUrl {
  static String baseUrl = EnvironmentConfig.config?.apiBaseUrl ?? '';
  static String googleClientId = EnvironmentConfig.config?.apiBaseUrl ?? '';
}
