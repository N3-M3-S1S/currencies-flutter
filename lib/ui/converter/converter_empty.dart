import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConverterEmpty extends StatelessWidget {
  const ConverterEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(Icons.swap_horiz, size: 80),
        FittedBox(
            child: Text("Conversion result will appear here",
                style: Theme.of(context).textTheme.headline6!))
      ]);
}
