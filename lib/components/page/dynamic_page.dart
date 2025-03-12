import 'package:flutter/material.dart';
import 'package:zenon_mqtt/classes/index.dart';
import 'package:zenon_mqtt/components/dynamic/dynamic_component.dart';

class DynamicPage extends StatefulWidget {
  const DynamicPage({super.key, required this.title, required this.structure});

  final Widget title;
  final ConfigStructureItem structure;

  @override
  State<DynamicPage> createState() => _DynamicPageState();
}

class _DynamicPageState extends State<DynamicPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child:
            widget.structure.components.isEmpty == true
                ? Container()
                : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...List<Widget>.generate(
                      widget.structure.components.length,
                      (index) => DynamicComponent(
                        component: widget.structure.components[index],
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}
