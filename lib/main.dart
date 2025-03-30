import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:finmentor/app.dart';
import 'package:finmentor/data/firebase_options.dart';
import 'package:finmentor/di/di.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //1. init firebase
  // if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
    );
  // } else {
  //   Firebase.app(); // toma la app existente
  // }

  // try {
  //   await FirebaseAuth.instance.signInAnonymously();
  // } on FirebaseAuthException catch (e) {
  //   switch (e.code) {
  //     case "operation-not-allowed":
  //       if (kDebugMode) {
  //         print("Anonymous auth hasn't been enabled for this project.");
  //       }
  //       break;
  //     default:
  //       if (kDebugMode) {
  //         print("Unknown error. $e");
  //       }
  //   }
  // }

  //2. init hydrated bloc
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory.web,
  );

  //4. init dependencies (that includes AnalyticsService)
  await di.init();

  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(App(savedThemeMode: savedThemeMode));

  //init the rest of services after the startup
  Future.delayed(const Duration(milliseconds: 500), () {
    _initNonCriticalServices();
  });
}

Future<void> _initNonCriticalServices() async {
  // Servicios no críticos para el arranque
}
