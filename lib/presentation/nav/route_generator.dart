import 'package:flutter/material.dart';
import 'package:finmentor/infrastructure/services/navigation_service.dart';
import 'package:finmentor/presentation/nav/nav_bar.dart';
import 'package:finmentor/presentation/pages/splash/splash.dart';
import 'package:finmentor/presentation/pages/notifications/notifications_page.dart';

class RouteGenerator {

  static final navigationService = NavigationService();


  static Route<dynamic> generateRouter(RouteSettings settings) {
    //final args = settings.arguments;
    navigationService.updateRoute(settings.name ?? '');

    switch (settings.name) {
      case '/':
        return buildTransition(const Splash(), settings: settings);
      case 'nav':
        return buildTransition(const NavBar(), settings: settings);
      case 'notifications':
        return buildTransition(const NotificationsPage(), settings: settings);
      default:
        return _errorRoute();
    }
  }

  static PageRouteBuilder buildTransition(Widget view, { RouteSettings? settings}){
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => view,
      settings: settings ?? const RouteSettings() ,
    );
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}