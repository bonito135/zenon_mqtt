import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zenon_mqtt/mixins/error_handler_mixin.dart';
import 'package:zenon_mqtt/mixins/loading_state_mixin.dart';

class LoadingButton extends StatefulWidget {
  const LoadingButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  final Future<void> Function() onPressed;
  final Widget child;

  @override
  State<LoadingButton> createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton>
    with LoadingStateMixin, ErrorHandlerMixin {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isLoading,
      builder: (context, value, child) {
        print(value);
        return Container(
          padding: EdgeInsets.all(30),
          child: ElevatedButton(
            autofocus: true,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.secondary,
            ),
            onPressed: () => handleFuture(runWithLoader(widget.onPressed)),
            child: value == false ? widget.child : CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
