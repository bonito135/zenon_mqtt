import 'package:flutter/material.dart';
import 'package:zenon_mqtt/l10n/app_localizations.dart';

class SettingsBottomSheet extends StatefulWidget {
  const SettingsBottomSheet({
    super.key,
    required this.setConfig,
    required this.setLocale,
  });

  final Function(String) setConfig;
  final Function(Locale) setLocale;

  @override
  State<SettingsBottomSheet> createState() => _SettingsBottomSheetState();
}

class _SettingsBottomSheetState extends State<SettingsBottomSheet> {
  final _formKey = GlobalKey<FormState>();
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
    final currentLocale = Localizations.localeOf(context);
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
                icon: Icon(IconData(0xe587, fontFamily: 'MaterialIcons')),
                child: Text(
                  AppLocalizations.of(context)!.topic,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
              Tab(
                icon: Icon(IconData(0xe366, fontFamily: 'MaterialIcons')),
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
            Padding(
              padding: EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          labelText:
                              AppLocalizations.of(context)!.connection_topic,
                          labelStyle: Theme.of(context).textTheme.labelMedium,
                        ),
                        textAlign: TextAlign.center,
                        controller: _topicInputController,
                        autofocus: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(
                              context,
                            )!.connection_topic_is_required;
                          }
                          return null;
                        },
                        onTapUpOutside: (event) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                        ),
                        onPressed:
                            () => {
                              if (_formKey.currentState!.validate())
                                {
                                  widget.setConfig(_topicInputController.text),

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      behavior: SnackBarBehavior.floating,
                                      duration: const Duration(seconds: 3),
                                      margin: EdgeInsets.all(20),
                                      backgroundColor:
                                          Theme.of(
                                            context,
                                          ).colorScheme.secondary,
                                      content: Row(
                                        children: [
                                          SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(width: 20),
                                          Text(
                                            AppLocalizations.of(
                                              context,
                                            )!.processing_data,
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Navigator.pop(context),
                                },
                            },
                        child: Text(
                          AppLocalizations.of(context)!.submit,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  ...AppLocalizations.supportedLocales.map((locale) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          locale.languageCode.toUpperCase(),
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                          ),
                          onPressed: () => {widget.setLocale(locale)},
                          child: Text(
                            currentLocale.languageCode.toLowerCase() ==
                                    locale.languageCode.toLowerCase()
                                ? AppLocalizations.of(context)!.applied
                                : AppLocalizations.of(context)!.apply,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
