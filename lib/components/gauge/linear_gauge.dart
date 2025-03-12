import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class LinearGauge extends StatefulWidget {
  const LinearGauge({super.key});

  @override
  State<LinearGauge> createState() => _LinearGaugeState();
}

class _LinearGaugeState extends State<LinearGauge> {
  @override
  Widget build(BuildContext context) {
    return SfLinearGauge(
      ranges: [LinearGaugeRange(startValue: 0, endValue: 50)],
      markerPointers: [LinearShapePointer(value: 50)],
      barPointers: [LinearBarPointer(value: 80)],
    );
  }
}
