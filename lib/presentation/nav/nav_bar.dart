import 'dart:async';

import 'package:finmentor/infrastructure/services/branch_service.dart';
import 'package:finmentor/infrastructure/services/posthog_service.dart';
import 'package:finmentor/presentation/bloc/home/home_cubit.dart';
import 'package:finmentor/presentation/pages/settings/settings_page.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:finmentor/di/di.dart';
import 'package:finmentor/presentation/bloc/authentication/authentication_cubit.dart';
import 'package:finmentor/presentation/bloc/trophies/trophies_cubit.dart';
import 'package:finmentor/presentation/pages/home/home_page.dart';
import 'package:finmentor/presentation/pages/courses/courses_page.dart';
import 'package:finmentor/presentation/pages/trophies/trophies_page.dart';

typedef TabIndex = int;

class TabIndices {
  static const TabIndex home = 0;
  static const TabIndex courses = 1;
  static const TabIndex trophies = 2;
  static const TabIndex settings = 3;

  static String getName(TabIndex index) {
    switch (index) {
      case home:
        return 'home';
      case courses:
        return 'courses';
      case trophies:
        return 'trophies';
      case settings:
        return 'settings';
      default:
        return 'unknown';
    }
  }
}

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => NavBarState();
}

class NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  List<Widget> tabItems = [];
  late final authenticationCubit = getIt<AuthenticationCubit>();
  late final homeCubit = getIt<HomeCubit>();
  late final trophiesCubit = getIt<TrophiesCubit>();
  //Branch
  StreamSubscription? _branchSubscription;

  @override
  void initState() {
    super.initState();

    //Analytics
    _initAnalytics();

    //Auth
    // if (Utils.getUser() == null) {
    //   authenticationCubit.ghostLogin();
    // }

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   coursesCubit
    //       .loadCourses(); // Cargar palabras después de que el widget esté montado
    // });

    //TabBar
    tabItems = [
      HomePage(homeCubit: homeCubit),
      CoursesPage(),
      TrophiesPage(trophiesCubit: trophiesCubit),
      const SettingsPage(),
    ];
  }

   void _initAnalytics() async {
      try {
        await PosthogService().initialize();
        //await BranchService().initialize();
      } catch (e) {
        if (kDebugMode) {
          print('Error al inicializar Analytics Tools: $e');
        }
      }
    }


  @override
  Widget build(BuildContext context) {
    double height = 117;
    return MultiBlocProvider(
        providers: [
          BlocProvider.value(value: authenticationCubit),
          //BlocProvider.value(value: coursesCubit),
        ],
        child: GestureDetector(
            //behavior: HitTestBehavior.opaque,
            onTap: () {
              //FocusScope.of(context).unfocus();
            },
            child: Scaffold(
                body: Center(
                  child: tabItems[_selectedIndex],
                ),
                bottomNavigationBar: SizedBox(
                    height: height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                       
                        Divider(
                          height: 1,
                          thickness: 1,
                          color: Colors.grey.shade300,
                        ),
                        FlashyTabBar(
                          animationCurve: Curves.linear,
                          selectedIndex: _selectedIndex,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          iconSize: 30,
                          showElevation: false,
                          onItemSelected: (index) => setState(() {
                            _selectedIndex = index;
                          }),
                          items: [
                            FlashyTabBarItem(
                              icon: SvgPicture.asset(
                                'assets/images/home.svg',
                                colorFilter: ColorFilter.mode(
                                  Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .color!,
                                  BlendMode.srcIn,
                                ),
                              ),
                              title: Text('Home',
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                            ),
                            FlashyTabBarItem(
                              icon: SvgPicture.asset('assets/images/course.svg',
                                  colorFilter: ColorFilter.mode(
                                    Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .color!,
                                    BlendMode.srcIn,
                                  )),
                              title: Text('Financial Terms',
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                            ),
                            FlashyTabBarItem(
                              icon:
                                  SvgPicture.asset('assets/images/trophie.svg',
                                      colorFilter: ColorFilter.mode(
                                        Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .color!,
                                        BlendMode.srcIn,
                                      )),
                              title: Text(
                                'Trophies',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                            FlashyTabBarItem(
                              icon:
                                  SvgPicture.asset('assets/images/settings.svg',
                                      colorFilter: ColorFilter.mode(
                                        Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .color!,
                                        BlendMode.srcIn,
                                      )),
                              title: Text(
                                'Settings',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )))));
  }

  @override
  void dispose() {
    _branchSubscription?.cancel();
    super.dispose();
  }
}
