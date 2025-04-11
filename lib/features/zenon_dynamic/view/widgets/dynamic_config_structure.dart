import 'package:flutter/material.dart';
import 'package:zenon_mqtt/features/database/repository/database.dart';
import 'package:zenon_mqtt/features/zenon_dynamic/view/pages/dynamic_page.dart';
import 'package:zenon_mqtt/l10n/app_localizations.dart';

class DynamicConfigStructure extends StatelessWidget {
  const DynamicConfigStructure({
    super.key,
    required this.configStructure,
    required this.currentPageIndex,
    required this.showBottomSheet,
    required this.setPageIndex,
  });

  final ConfigStructureTableData? configStructure;
  final int currentPageIndex;
  final Function() showBottomSheet;
  final Function(int) setPageIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(
          configStructure?.content!.structure[currentPageIndex].sectionName ??
              "",
        ),
        titleTextStyle: Theme.of(context).textTheme.titleLarge,
        actions: [
          IconButton(
            onPressed: () => showBottomSheet(),
            icon: const Icon(Icons.settings_input_antenna, color: Colors.white),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child:
            (configStructure?.content!.structure.length ?? 0) < 2
                ? const SizedBox.shrink()
                : NavigationBar(
                  labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
                  selectedIndex: currentPageIndex,
                  onDestinationSelected: (int index) {
                    setPageIndex(index);
                  },
                  destinations: List<Widget>.generate(
                    configStructure?.content!.structure.length ?? 0,
                    (index) => NavigationDestination(
                      icon: const Icon(Icons.explore),
                      label:
                          configStructure
                              ?.content!
                              .structure[index]
                              .sectionName ??
                          "",
                    ),
                  ),
                ),
      ),
      body:
          configStructure?.content!.structure[currentPageIndex] == null
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
                        onPressed: () => showBottomSheet(),
                        child: Text(
                          "Connect to Zenon istance",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              )
              : SafeArea(
                child:
                    configStructure?.content!.structure.isEmpty ?? true
                        ? Center(
                          child: Text(
                            AppLocalizations.of(context)!.no_config_applied,
                          ),
                        )
                        : DynamicPage(
                          title: Text(
                            configStructure
                                    ?.content!
                                    .structure[currentPageIndex]
                                    .sectionName ??
                                "",
                          ),
                          structure:
                              configStructure!
                                  .content!
                                  .structure[currentPageIndex],
                        ),
              ),
    );
  }
}
