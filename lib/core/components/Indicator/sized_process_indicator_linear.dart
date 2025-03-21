import 'package:flutter/material.dart';

class SizedProcessIndicatorLinear extends StatelessWidget {
  const SizedProcessIndicatorLinear({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LinearProgressIndicator(
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ),
        ],
      ),
    );
  }
}
