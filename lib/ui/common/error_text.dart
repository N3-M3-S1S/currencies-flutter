import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  final String errorText;

  const ErrorText({
    Key? key,
    required this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(errorText + errorText,
        style: theme.textTheme.subtitle1!.copyWith(color: theme.errorColor));
  }
}
