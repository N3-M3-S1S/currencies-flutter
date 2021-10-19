import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'converter_viewmodel.dart';

class SwapCurrenciesButton extends HookConsumerWidget {
  const SwapCurrenciesButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 250),
    );
    return RotationTransition(
        turns: Tween(begin: 0.0, end: -0.5).animate(animationController),
        child: IconButton(
            iconSize: 38,
            onPressed: () {
              animationController.forward(from: 0);
              ref.read(converterScreenViewModelProvider).swapCurrencies();
            },
            icon: const Icon(Icons.change_circle),
            color: Theme.of(context).colorScheme.primary));
  }
}