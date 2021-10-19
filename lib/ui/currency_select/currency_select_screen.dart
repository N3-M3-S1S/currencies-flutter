import 'package:currencies/ui/common/currency_filter_input.dart';
import 'package:currencies/ui/common/currency_list_item.dart';
import 'package:currencies/ui/currency_select/currency_select_list.dart';
import 'package:currencies/ui/currency_select/currency_select_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'currency_select_viewmodel.dart';

//see https://github.com/flutter/flutter/issues/67219
Widget? _bottomSheetChildWidget;
void showCurrencySelectBottomSheet(
    BuildContext context, OnCurrencyClick onCurrencySelected) {
  _bottomSheetChildWidget = null;
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
            initialChildSize: 1,
            expand: false,
            builder: (_, scrollController) {
              _bottomSheetChildWidget ??= CurrencySelectScreen(
                  currenciesListScrollController: scrollController,
                  onCurrencySelected: (selectedCurrency) {
                    onCurrencySelected(selectedCurrency);
                    Navigator.of(context).pop();
                  });
              return _bottomSheetChildWidget!;
            });
      }).whenComplete(() {
    _bottomSheetChildWidget = null;
  });
}

class CurrencySelectScreen extends HookConsumerWidget {
  final OnCurrencyClick _onCurrencySelected;
  final ScrollController? _currenciesListScrollController;

  const CurrencySelectScreen(
      {Key? key,
      ScrollController? currenciesListScrollController,
      required OnCurrencyClick onCurrencySelected})
      : _onCurrencySelected = onCurrencySelected,
        _currenciesListScrollController = currenciesListScrollController,
        super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(currencySelectViewModelProvider);
    final state = useValueListenable(viewModel.state);
    final widgetForState = _buildWidgetForState(state);
    return Column(
      children: [
        CurrencyFilterInput(
            onQueryChanged: viewModel.filterCurrencies,
            onCleared: viewModel.resetFilter),
        const SizedBox(height: 8),
        Flexible(child: widgetForState)
      ],
    );
  }

  Widget _buildWidgetForState(CurrencySelectState state) {
    return state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        ready: (currencies) => CurrencySelectList(
            scrollController: _currenciesListScrollController,
            currencies: currencies,
            onCurrencySelected: _onCurrencySelected));
  }
}
