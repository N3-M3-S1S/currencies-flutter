import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'converter_viewmodel.dart';

class ConvertButton extends HookConsumerWidget {
  const ConvertButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(converterScreenViewModelProvider);
    final buttonEnabled = useValueListenable(viewModel.convertAvailable);
    final onClick = buttonEnabled ? viewModel.convert : null;
    return ElevatedButton(onPressed: onClick, child: const Text("Convert"));
  }
}
