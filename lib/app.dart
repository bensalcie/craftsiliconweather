import 'package:craftsiliconweather/core/common/constants/app_strings.dart';
import 'package:craftsiliconweather/core/common/constants/routes.dart';
import 'package:craftsiliconweather/core/common/presentation/pages/no_internet_page.dart';
import 'package:craftsiliconweather/core/common/presentation/widgets/scaffold_with_navbar.dart';
import 'package:craftsiliconweather/features/home/presentation/pages/home_page.dart';
import 'package:craftsiliconweather/features/search/presentation/pages/search_page.dart';
import 'package:craftsiliconweather/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

// Set up nested navigation using ShellRoute,
// which is a pattern where an additional Navigator is placed in the widget tree
// to be used instead of the root navigator. This allows deep-links to display
// pages along with other UI components such as a BottomNavigationBar.
//
// Display a route within a ShellRoute and also
// push a screen using a different navigator (such as the root Navigator) by
// providing a `parentNavigatorKey`.

///  How to use [ShellRoute]

class App extends StatelessWidget {
  /// Creates a [App]
  App({super.key}) {
    //checkForUpdate();
  }

  final GoRouter _router = GoRouter(
    navigatorKey: _rootNavigatorKey,

    // initialLocation:
    // initialLocation: home_page_route,
    initialLocation: home_page_route,

    routes: <RouteBase>[
      /// Application shell
      ShellRoute(
          navigatorKey: _shellNavigatorKey,
          pageBuilder:
              (BuildContext context, GoRouterState state, Widget child) {
            return NoTransitionPage(child: ScaffoldWithNavBar(child: child));
          },
          routes: <RouteBase>[
            /// The first screen to display in the bottom navigation bar.

            //Modern Home Page.
            GoRoute(
                path: home_page_route,
                builder: (BuildContext context, GoRouterState state) {
                  return const HomePage();
                },
                routes: [
                  GoRoute(
                    path: search_page_index,
                    builder: (BuildContext context, GoRouterState state) {
                      return const SearchPage();
                    },
                  ),
                  GoRoute(
                    path: no_internet_page_route,
                    builder: (BuildContext context, GoRouterState state) {
                      return NoInternetPage(
                        onRetry: () {
                          GoRouter.of(context).go(home_page_route);
                        },
                      );
                    },
                  ),
                ]),
            GoRoute(
                path: search_page_route,
                builder: (BuildContext context, GoRouterState state) {
                  return const SearchPage();
                },
                routes: [
                  GoRoute(
                    path: no_internet_page_route,
                    builder: (BuildContext context, GoRouterState state) {
                      return NoInternetPage(
                        onRetry: () {
                          GoRouter.of(context).go(search_page_route);
                        },
                      );
                    },
                  ),
                ]),
          ]),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: app_title,
      theme: AppTheme.main(Brightness.light),
      darkTheme: AppTheme.main(Brightness.dark),
      routerConfig: _router,
    );
  }
}
