import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:azbox/azbox.dart';
import 'package:finmentor/infrastructure/constants/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:finmentor/app.dart';
import 'package:finmentor/data/firebase_options.dart';
import 'package:finmentor/di/di.dart' as di;
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // OneSignal.Debug.setLogLevel(OSLogLevel.none);
  // OneSignal.initialize(Constants.oneSignalAppId);
  // OneSignal.Notifications.requestPermission(true);

  //1. init firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  

  //2. init hydrated bloc
  // HydratedBloc.storage = await HydratedStorage.build(
  //   storageDirectory: HydratedStorageDirectory.web
  // );

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );

  // 3. Initialize Azbox
  await Azbox.ensureInitialized(
      apiKey: Constants.kAzboxApiKey, projectId: Constants.kAzboxProjectId);

  //4. init dependencies (that includes AnalyticsService)
  await di.init();

  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(Azbox(child: App(savedThemeMode: savedThemeMode)));

  //init the rest of services after the startup
  Future.delayed(const Duration(milliseconds: 500), () {
    _initNonCriticalServices();
  });
}

Future<void> _initNonCriticalServices() async {
  // Servicios no críticos para el arranque
}
