import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:zenon_mqtt/core/localizations/dynamic_localizations.dart';
import 'package:zenon_mqtt/features/database/repository/database.dart';
import 'package:zenon_mqtt/features/zenon_dynamic/view/pages/dynamic_page.dart';
import 'package:zenon_mqtt/l10n/app_localizations.dart';

class DynamicConfigStructure extends StatelessWidget {
  const DynamicConfigStructure({
    super.key,
    required this.connectionState,
    required this.configStructure,
    required this.showSettings,
  });

  final MqttConnectionState connectionState;
  final ConfigStructureTableData? configStructure;
  final Function() showSettings;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(configStructure?.content!.title ?? ""),
        titleTextStyle: Theme.of(context).textTheme.titleLarge,
        actions: [
          IconButton(
            onPressed: () => showSettings(),
            icon: const Icon(Icons.settings, color: Colors.white),
          ),
        ],
      ),
      body:
          connectionState == MqttConnectionState.disconnected
              ? SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(AppLocalizations.of(context)!.no_config_applied),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                        ),
                        onPressed: () => showSettings(),
                        child: Text(
                          AppLocalizations.of(
                            context,
                          )!.connect_to_zenon_instace,
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              )
              : SafeArea(
                child:
                    configStructure?.content!.structure.isEmpty == true
                        ? Center(
                          child: Text(
                            AppLocalizations.of(context)!.no_config_applied,
                          ),
                        )
                        : Column(
                          children: [
                            Flexible(
                              child: ListView.builder(
                                itemCount:
                                    configStructure
                                        ?.content!
                                        .structure
                                        .length ??
                                    0,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      ExpansionTile(
                                        shape: LinearBorder.none,
                                        collapsedShape: LinearBorder.none,
                                        tilePadding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 0,
                                        ),
                                        childrenPadding:
                                            const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 5,
                                            ),
                                        iconColor: Colors.white,
                                        collapsedIconColor: Colors.white,
                                        title: Row(
                                          children: [
                                            configStructure
                                                        ?.content
                                                        ?.structure[index]
                                                        .sectionIconCodePoint
                                                        .isNotEmpty ==
                                                    true
                                                ? Icon(
                                                  IconData(
                                                    int.parse(
                                                      configStructure!
                                                          .content!
                                                          .structure[index]
                                                          .sectionIconCodePoint,
                                                    ),
                                                    fontFamily: 'MaterialIcons',
                                                  ),
                                                )
                                                : SizedBox.shrink(),
                                            SizedBox(width: 10),
                                            Text(
                                              DynamicLocalization.translate(
                                                configStructure
                                                        ?.content!
                                                        .structure[index]
                                                        .sectionName ??
                                                    "",
                                              ).toUpperCase(),
                                              style:
                                                  Theme.of(
                                                    context,
                                                  ).textTheme.bodyLarge,
                                            ),
                                          ],
                                        ),
                                        children: [
                                          configStructure
                                                      ?.content
                                                      ?.structure
                                                      .isNotEmpty ==
                                                  true
                                              ? DynamicPage(
                                                structure:
                                                    configStructure!
                                                        .content!
                                                        .structure[index],
                                              )
                                              : SizedBox.shrink(),
                                        ],
                                      ),
                                      configStructure
                                                  ?.content!
                                                  .structure
                                                  .length ==
                                              index + 1
                                          ? SizedBox(height: 40)
                                          : SizedBox.shrink(),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
              ),
    );
  }
}
