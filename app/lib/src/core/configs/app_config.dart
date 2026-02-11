import 'package:ai_assessment/src/core/configs/environment/environment_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppConfig {
  Future<void> appInitSetup(String env) async {
    WidgetsFlutterBinding.ensureInitialized();

    await EnvironmentConfig.initialize(env);

    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
    );
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp],
    );

  }
}
