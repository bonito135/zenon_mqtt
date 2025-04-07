import 'package:flutter/cupertino.dart';
import 'package:zenon_mqtt/features/zenon_dynamic/view/widgets/dynamic_component.dart';
import 'package:zenon_mqtt/features/zenon_dynamic/model/_index.dart';

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
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: ListView.builder(
                itemCount: widget.structure.components.length,
                itemBuilder: (context, index) {
                  return DynamicComponent(
                    component: widget.structure.components[index],
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
