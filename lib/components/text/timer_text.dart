import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:zenon_mqtt/classes/structure.dart';
import 'package:zenon_mqtt/functions/time.dart';

class TimerText extends StatefulWidget {
  const TimerText({super.key, required this.text});

  final String text;

  @override
  State<TimerText> createState() => _TimerTextState();
}

class _TimerTextState extends State<TimerText> {
  @override
  Widget build(BuildContext context) {
    return TimerBuilder.periodic(
      Duration(seconds: 1),
      builder: (context) {
        return Text(
          style: Theme.of(context).textTheme.bodySmall,
          representTimeDifferenceInWords(
            getTimeDifferenceFromNow(
              StructureComponent.fromJson(
                jsonDecode(widget.text) as Map<String, dynamic>,
              ).lastUpdateTime!.replaceAll('.', '-'),
            ),
          ),
        );
      },
    );
  }
}
