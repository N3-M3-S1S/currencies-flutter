import 'dart:async';

import 'package:currencies/ui/app/navigation/darkmode_icon_button.dart';
import 'package:currencies/ui/converter/converter_screen.dart';
import 'package:currencies/ui/exchange_rates/exchange_rates_screen.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import 'app_route.dart';

@singleton
class AppRouteDelegate extends RouterDelegate<AppRoute>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppRoute> {
  AppRouteDelegate(this._logger);

  final Logger _logger;
  final GlobalKey<NavigatorState> _navKey = GlobalKey<NavigatorState>();
  final List<AppRoute> _routes = [AppRoute.converter, AppRoute.exchangeRates];
  late AppRoute _currentRoute = _routes.first;

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navKey;

  @override
  AppRoute get currentConfiguration {
    _logger.d("Current route: $_currentRoute");
    return _currentRoute;
  }

  @override
  Widget build(BuildContext context) => Overlay(initialEntries: [
        OverlayEntry(
            builder: (context) => Scaffold(
                appBar: AppBar(
                    title: const Text("Currencies"),
                    actions: const [DarkModeIconButton()]),
                body: Navigator(
                  key: _navKey,
                  pages: [
                    if (_currentRoute == AppRoute.converter)
                      const MaterialPage(
                          key: ValueKey(AppRoute.converter),
                          child: ConverterScreen())
                    else
                      const MaterialPage(
                          key: ValueKey(AppRoute.exchangeRates),
                          child: ExchangeRatesScreen())
                  ],
                  onPopPage: (route, result) {
                    return route.didPop(result);
                  },
                ),
                bottomNavigationBar: BottomNavigationBar(
                    items: _createBottomNavigationTabs(),
                    currentIndex: _getTabIndexForCurrentRoute(),
                    onTap: (i) => _handleTabClick(i))))
      ]);

  List<BottomNavigationBarItem> _createBottomNavigationTabs() => const [
        BottomNavigationBarItem(
            icon: Icon(Icons.swap_horiz), label: "Converter"),
        BottomNavigationBarItem(icon: Icon(Icons.list), label: "Exchange rates")
      ];

  void _handleTabClick(int tabIndex) {
    _popAllPopupRoutes();
    _currentRoute = _routes[tabIndex];
    _logger.d("Navigate to route $_currentRoute");
    notifyListeners();
  }

  void _popAllPopupRoutes() {
    _navKey.currentState!.popUntil((route) {
      return route is! PopupRoute;
    });
  }

  int _getTabIndexForCurrentRoute() => _routes.indexOf(_currentRoute);

  @override
  Future<void> setNewRoutePath(AppRoute configuration) async {
    _currentRoute = configuration;
  }
}
