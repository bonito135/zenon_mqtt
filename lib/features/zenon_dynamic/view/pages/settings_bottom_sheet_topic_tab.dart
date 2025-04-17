import 'package:flutter/material.dart';
import 'package:zenon_mqtt/features/zenon_dynamic/model/convert.dart';
import 'package:zenon_mqtt/features/zenon_dynamic/repository/mqtt_connection_repository.dart';
import 'package:zenon_mqtt/features/zenon_dynamic/view/widgets/settings_topic/settings_bottom_sheet_topic_public.dart';
import 'package:zenon_mqtt/features/zenon_dynamic/view/widgets/settings_topic/settings_bottom_sheet_topic_secure.dart';
import 'package:zenon_mqtt/l10n/app_localizations.dart';

class SettingsBottomSheetTopicTab extends StatefulWidget {
  const SettingsBottomSheetTopicTab({super.key, required this.setConfig});

  final Function(MqttConnectionRepository<ConfigStructure>) setConfig;

  @override
  State<StatefulWidget> createState() => _SettingsBottomSheetTopicTabState();
}

class _SettingsBottomSheetTopicTabState
    extends State<SettingsBottomSheetTopicTab> {
  final List<bool> _selectedConnectionVariants = <bool>[true, false];

  @override
  Widget build(BuildContext context) {
    final List<Widget> connectionVariants = <Widget>[
      Text(AppLocalizations.of(context)!.public),
      Text(AppLocalizations.of(context)!.secure),
    ];

    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          const SizedBox(height: 5),
          ToggleButtons(
            direction: Axis.horizontal,
            onPressed: (int index) {
              setState(() {
                for (int i = 0; i < _selectedConnectionVariants.length; i++) {
                  _selectedConnectionVariants[i] = i == index;
                }
              });
            },
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            borderColor: Theme.of(context).colorScheme.primary,
            selectedBorderColor: Colors.white,
            selectedColor: Colors.white,
            fillColor: Theme.of(context).colorScheme.primary,
            color: Theme.of(context).colorScheme.primary,
            constraints: const BoxConstraints(minHeight: 30.0, minWidth: 100.0),
            isSelected: _selectedConnectionVariants,
            children: connectionVariants,
          ),
          _selectedConnectionVariants[0] == true
              ? SettingsBottomSheetTopicPublic(setConfig: widget.setConfig)
              : SettingsBottomSheetTopicSecure(setConfig: widget.setConfig),
        ],
      ),
    );
  }
}
