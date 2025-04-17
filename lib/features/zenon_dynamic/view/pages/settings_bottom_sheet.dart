import 'package:flutter/material.dart';
import 'package:zenon_mqtt/features/zenon_dynamic/model/convert.dart';
import 'package:zenon_mqtt/features/zenon_dynamic/repository/mqtt_connection_repository.dart';
import 'package:zenon_mqtt/features/zenon_dynamic/view/pages/settings_bottom_sheet_localization.dart';
import 'package:zenon_mqtt/features/zenon_dynamic/view/pages/settings_bottom_sheet_topic_tab.dart';
import 'package:zenon_mqtt/l10n/app_localizations.dart';

class SettingsBottomSheet extends StatefulWidget {
  const SettingsBottomSheet({
    super.key,
    required this.setConfig,
    required this.setLocale,
  });

  final Function(MqttConnectionRepository<ConfigStructure>) setConfig;
  final Function(Locale) setLocale;

  @override
  State<SettingsBottomSheet> createState() => _SettingsBottomSheetState();
}

class _SettingsBottomSheetState extends State<SettingsBottomSheet> {
  late final TextEditingController _topicInputController;

  @override
  void initState() {
    _topicInputController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _topicInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          toolbarHeight: 0,
          automaticallyImplyLeading: false,
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.swap_vertical_circle_outlined),
                child: Text(
                  AppLocalizations.of(context)!.connection,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
              Tab(
                icon: Icon(Icons.language),
                child: Text(
                  AppLocalizations.of(context)!.language,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: SettingsBottomSheetTopicTab(
                setConfig: (topic) => widget.setConfig(topic),
              ),
            ),
            SingleChildScrollView(
              child: SettingsBottomSheetLocalization(
                setLocale: (locale) => widget.setLocale(locale),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
