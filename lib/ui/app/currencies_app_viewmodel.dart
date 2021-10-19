import 'package:currencies/di/injectable.dart';
import 'package:currencies/ui/app/configuration/app_configuration.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:injectable/injectable.dart';

final currenciesAppViewModelProvider =
    Provider<CurrenciesAppViewModel>((_) => getIt());

@injectable
class CurrenciesAppViewModel {
  final AppConfiguration _appConfiguration;
  late final ValueNotifier<bool> _darkModeEnabled =
      ValueNotifier(_appConfiguration.darkModeEnabled);

  ValueListenable<bool> get darkModeEnabled => _darkModeEnabled;

  CurrenciesAppViewModel(this._appConfiguration);

  void toggleDarkMode() {
    _darkModeEnabled.value = !_darkModeEnabled.value;
    _appConfiguration.saveDarkModeState(_darkModeEnabled.value);
  }
}
