import 'package:craftsiliconweather/core/common/constants/app_strings.dart';
import 'package:craftsiliconweather/core/common/constants/routes.dart';
import 'package:craftsiliconweather/core/common/presentation/widgets/bottom_menu_icon.dart';
import 'package:craftsiliconweather/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNavBar extends StatefulWidget {
  /// Constructs an [ScaffoldWithNavBar].
  const ScaffoldWithNavBar({
    required this.child,
    super.key,
  });

  /// The widget to display in the body of the Scaffold.
  /// In this sample, it is home Navigator.
  final Widget child;

  @override
  State<ScaffoldWithNavBar> createState() => _ScaffoldWithNavBarState();

  static int _calculateSelectedIndex(
      BuildContext context, String? homePageIndex) {
    final String location = GoRouterState.of(context).uri.toString();
    if (location.startsWith(home_page_route)) {
      return 0;
    }
    if (location.startsWith(search_page_route)) {
      return 1;
    }

    return 0;
  }
}

class _ScaffoldWithNavBarState extends State<ScaffoldWithNavBar>
    with WidgetsBindingObserver {
  String? homePageIndex;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      persistentFooterAlignment: AlignmentDirectional.center,
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kLightColor,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        selectedLabelStyle:
            const TextStyle(letterSpacing: 0, height: 0, fontSize: 0),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            activeIcon: BottomMenuIcon(
                assetsvgicon: home_icon, iconlabel: home_label, isActive: true),
            icon: BottomMenuIcon(
                assetsvgicon: home_icon,
                iconlabel: home_label,
                isActive: false),
            label: home_label,
          ),
          BottomNavigationBarItem(
            activeIcon: BottomMenuIcon(
                assetsvgicon: search_icon,
                iconlabel: search_label,
                isActive: true),
            icon: BottomMenuIcon(
                assetsvgicon: search_icon,
                iconlabel: search_label,
                isActive: false),
            label: search_label,
          ),
        ],
        currentIndex:
            ScaffoldWithNavBar._calculateSelectedIndex(context, homePageIndex),
        onTap: (int idx) => _onItemTapped(idx, context),
      ),
    );
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).go(home_page_route);
        break;
      case 1:
        GoRouter.of(context).go(search_page_route);
        break;
    }
  }
}
