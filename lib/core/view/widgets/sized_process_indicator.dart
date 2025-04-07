import 'package:flutter/material.dart';

class SizedProcessIndicator extends StatelessWidget {
  const SizedProcessIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            padding: EdgeInsets.all(30),
          ),
        ],
      ),
    );
  }
}
