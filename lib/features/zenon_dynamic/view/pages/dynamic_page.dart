import 'package:flutter/cupertino.dart';
import 'package:zenon_mqtt/features/database/repository/database.dart';
import 'package:zenon_mqtt/features/zenon_dynamic/model/convert.dart';
import 'package:zenon_mqtt/features/zenon_dynamic/view/widgets/dynamic_component.dart';

class DynamicPage extends StatefulWidget {
  const DynamicPage({super.key, required this.structure});

  final ConfigStructureItem structure;

  @override
  State<DynamicPage> createState() => _DynamicPageState();
}

class _DynamicPageState extends State<DynamicPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CupertinoScrollbar(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
            child: Column(
              children: [
                ...widget.structure.elements.map((element) {
                  return DynamicComponent(
                    element: StructureComponentTableData(
                      type: element.type,
                      tagName: element.tagName,
                      description: element.description,
                      unit: element.unit,
                      digits: element.digits,
                      value: element.value.toString(),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
