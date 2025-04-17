import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:zenon_mqtt/core/functions/show_snackbar.dart';
import 'package:zenon_mqtt/features/zenon_dynamic/model/convert.dart';
import 'package:zenon_mqtt/features/zenon_dynamic/repository/mqtt_connection_repository.dart';
import 'package:zenon_mqtt/l10n/app_localizations.dart';

class SettingsBottomSheetTopicPublic extends StatefulWidget {
  const SettingsBottomSheetTopicPublic({super.key, required this.setConfig});

  final Function(MqttConnectionRepository<ConfigStructure>) setConfig;

  @override
  State<SettingsBottomSheetTopicPublic> createState() =>
      _SettingsBottomSheetTopicPublicState();
}

class _SettingsBottomSheetTopicPublicState
    extends State<SettingsBottomSheetTopicPublic> {
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: TextFormField(
                minLines: 1,
                maxLines: 2,
                decoration: InputDecoration(
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  errorStyle: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.red,
                  ),
                  labelText: AppLocalizations.of(context)!.connection_topic,
                  labelStyle: Theme.of(context).textTheme.labelMedium,
                  isDense: true,
                ),
                style: Theme.of(context).textTheme.bodyMedium,
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
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                onPressed:
                    () => {
                      if (_formKey.currentState!.validate())
                        {
                          widget.setConfig(
                            MqttConnectionRepository<ConfigStructure>(
                              client: MqttServerClient(
                                dotenv.env['MQTT_SERVER_PROVIDER']!,
                                'Mqtt_config',
                              ),
                              topic: _topicInputController.text,
                              connMess: MqttConnectMessage(),
                              autoReconnect: true,
                              secure: false,
                            ),
                          ),
                          showSnackBar(
                            context: context,
                            message:
                                AppLocalizations.of(context)!.processing_data,
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
    );
  }
}
