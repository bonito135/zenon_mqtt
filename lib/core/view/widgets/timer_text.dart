import 'package:flutter/material.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:zenon_mqtt/core/functions/time.dart';

class TimerText extends StatefulWidget {
  const TimerText({super.key, required this.lastUpdateTime});

  final String? lastUpdateTime;

  @override
  State<TimerText> createState() => _TimerTextState();
}

class _TimerTextState extends State<TimerText> {
  @override
  Widget build(BuildContext context) {
    return widget.lastUpdateTime == null
        ? const Text("N/A")
        : TimerBuilder.periodic(
          Duration(seconds: 1),
          builder: (context) {
            return Text(
              style: Theme.of(context).textTheme.bodySmall,
              representTimeDifferenceInWords(
                context,
                getTimeDifferenceFromNow(
                  widget.lastUpdateTime?.replaceAll('.', '-') ?? "",
                ),
              ),
            );
          },
        );
  }
}
