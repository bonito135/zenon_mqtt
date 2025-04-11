import 'package:flutter/material.dart';

class ConfigStructureBottomSheet extends StatefulWidget {
  const ConfigStructureBottomSheet({super.key, required this.setConfig});

  final Function(String) setConfig;

  @override
  State<ConfigStructureBottomSheet> createState() =>
      _ConfigStructureBottomSheetState();
}

class _ConfigStructureBottomSheetState
    extends State<ConfigStructureBottomSheet> {
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
    return SingleChildScrollView(
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: SizedBox(
          width: double.infinity,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 20,
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Connection topic",
                      labelStyle: Theme.of(context).textTheme.bodyMedium,
                    ),
                    textAlign: TextAlign.center,
                    controller: _topicInputController,
                    autofocus: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Connection topic is required";
                      }
                      return null;
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
                                      Theme.of(context).colorScheme.secondary,
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
                                        'Processing Data',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Navigator.pop(context),
                            },
                        },
                    child: const Text(
                      "Submit",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    // SizedBox(
    //   height: 400,
    //   width: double.infinity,
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.start,
    //     // crossAxisAlignment: CrossAxisAlignment.center,
    //     children: [
    //       const Text("Insert connection topic"),
    //       TextField(controller: widget.controller),
    //     ],
    //   ),
    // );
  }
}
