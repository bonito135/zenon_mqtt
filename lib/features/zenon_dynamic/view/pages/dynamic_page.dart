import 'package:flutter/cupertino.dart';
import 'package:zenon_mqtt/features/database/repository/database.dart';
import 'package:zenon_mqtt/features/zenon_dynamic/model/convert.dart';
import 'package:zenon_mqtt/features/zenon_dynamic/view/widgets/dynamic_component.dart';

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: CupertinoScrollbar(
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: ListView.builder(
                itemCount: widget.structure.elements.length,
                itemBuilder: (context, index) {
                  final data = widget.structure.elements[index];
                  return DynamicComponent(
                    element: StructureComponentTableData(
                      type: data.type,
                      tagName: data.tagName,
                      description: data.description,
                      unit: data.unit,
                      digits: data.digits,
                      value: data.value.toString(),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
