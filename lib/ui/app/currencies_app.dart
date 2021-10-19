import 'package:currencies/di/injectable.dart';
import 'package:currencies/ui/app/currencies_app_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'navigation/app_route_delegate.dart';
import 'navigation/app_route_information_parser.dart';

class CurrenciesApp extends HookConsumerWidget {
  const CurrenciesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(currenciesAppViewModelProvider);
    final darkModeEnabled = useValueListenable(viewModel.darkModeEnabled);
    return MaterialApp.router(
        theme: _buildAppTheme(darkModeEnabled),
        title: "Currencies",
        routeInformationParser: getIt<AppRouteInformationParser>(),
        routerDelegate: getIt<AppRouteDelegate>());
  }

  ThemeData _buildAppTheme(bool darkModeEnabled) => ThemeData(
      brightness: darkModeEnabled ? Brightness.dark : Brightness.light,
      inputDecorationTheme:
          const InputDecorationTheme(border: OutlineInputBorder()));
}
