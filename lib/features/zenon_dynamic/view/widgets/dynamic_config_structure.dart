import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:zenon_mqtt/core/localizations/dynamic_localizations.dart';
import 'package:zenon_mqtt/features/database/repository/database.dart';
// import 'package:zenon_mqtt/features/zenon_dynamic/repository/mqtt_connection_repository.dart';
import 'package:zenon_mqtt/features/zenon_dynamic/view/pages/dynamic_page.dart';
import 'package:zenon_mqtt/l10n/app_localizations.dart';

class DynamicConfigStructure extends StatelessWidget {
  const DynamicConfigStructure({
    super.key,
    required this.connectionState,
    required this.configStructure,
    required this.showSettings,
  });

  final MqttClientConnectionStatus? connectionState;
  final ConfigStructureTableData? configStructure;
  final Function() showSettings;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Row(children: [Text(configStructure?.content!.title ?? "")]),
        titleTextStyle: Theme.of(context).textTheme.titleLarge,
        actions: [
          Row(
            children: [
              connectionState?.state == MqttConnectionState.connected
                  ? const Icon(Icons.album, color: Colors.green, size: 10)
                  : connectionState?.state == MqttConnectionState.connecting
                  ? const Icon(Icons.album, color: Colors.blue, size: 10)
                  : const Icon(Icons.album, color: Colors.red, size: 10),
            ],
          ),
          IconButton(
            onPressed: () => showSettings(),
            icon: const Icon(Icons.settings, color: Colors.white),
          ),
        ],
      ),
      body:
          configStructure?.content?.structure.isEmpty == true ||
                  configStructure == null
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppLocalizations.of(context)!.no_config_applied),
                  ],
                ),
              )
              : Column(
                children: [
                  Flexible(
                    child: ListView.builder(
                      itemCount:
                          configStructure?.content!.structure.length ?? 0,
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
                              childrenPadding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              iconColor: Colors.white,
                              collapsedIconColor: Colors.white,
                              title: Row(
                                children: [
                                  Image.network(
                                    width: 22,
                                    height: 22,
                                    configStructure
                                            ?.content
                                            ?.structure[index]
                                            .iconLink ??
                                        "",
                                    errorBuilder: (context, error, stackTrace) {
                                      return SvgPicture.string(
                                        width: 14,
                                        height: 14,
                                        '<svg xmlns="http://www.w3.org/2000/svg" viewBox="${configStructure?.content?.structure[index].svgViewBox}"><path fill="${configStructure?.content?.structure[index].svgColor ?? #ffffff}" d="${configStructure?.content?.structure[index].svgPath}"/></svg>',
                                      );
                                    },
                                  ),
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
                                        Theme.of(context).textTheme.bodyLarge,
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
                            configStructure?.content!.structure.length ==
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
    );
  }
}
