import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../currencies_app_viewmodel.dart';

class DarkModeIconButton extends HookConsumerWidget {
  const DarkModeIconButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(currenciesAppViewModelProvider);
    final darkModeEnabled = useValueListenable(viewModel.darkModeEnabled);
    final icon = darkModeEnabled ? Icons.dark_mode : Icons.dark_mode_outlined;
    return IconButton(
        icon: Icon(icon),
        tooltip: "Dark mode",
        onPressed: viewModel.toggleDarkMode);
  }
}
