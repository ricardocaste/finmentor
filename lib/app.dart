import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:finmentor/presentation/nav/route_generator.dart';
import 'package:finmentor/presentation/themes.dart';

class App extends StatelessWidget {
  const App({super.key, this.savedThemeMode});

  final AdaptiveThemeMode? savedThemeMode;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: Themes.light,
      dark: Themes.dark,
      initial: savedThemeMode ?? AdaptiveThemeMode.light,
      builder: (theme, darkTheme) =>
        MaterialApp(
          debugShowCheckedModeBanner: false,
          showPerformanceOverlay: false,
          darkTheme: darkTheme,
          theme: theme,
          initialRoute: '/',
          onGenerateRoute: RouteGenerator.generateRouter,
          
          
      )
    );
  }
}