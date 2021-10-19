import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CurrencyFilterInput extends HookWidget {
  final ValueChanged<String> _onQueryChanged;
  final VoidCallback _onCleared;

  const CurrencyFilterInput(
      {Key? key,
      required ValueChanged<String> onQueryChanged,
      required VoidCallback onCleared})
      : _onQueryChanged = onQueryChanged,
        _onCleared = onCleared,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final clearIconVisible = useState(false);
    final filterInputFocusNode = useFocusNode();
    final filterInputTextController = useTextEditingController();

    final clearIconButton = clearIconVisible.value
        ? IconButton(
            onPressed: () {
              filterInputTextController.clear();
              filterInputFocusNode.unfocus();
              clearIconVisible.value = false;
              _onCleared();
            },
            icon: const Icon(Icons.clear))
        : null;

    final inputDecoration = InputDecoration(
        border: const UnderlineInputBorder(),
        contentPadding: const EdgeInsets.all(16),
        hintText: "Currency name or code",
        suffixIcon: clearIconButton);

    return TextFormField(
        focusNode: filterInputFocusNode,
        controller: filterInputTextController,
        decoration: inputDecoration,
        onChanged: (query) {
          clearIconVisible.value = query.isNotEmpty;
          _onQueryChanged(query);
        });
  }
}
