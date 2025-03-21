import 'package:flutter/material.dart';
import 'package:zenon_mqtt/core/mixins/error_handler_mixin.dart';
import 'package:zenon_mqtt/core/mixins/loading_state_mixin.dart';

class PrimaryButton extends StatefulWidget {
  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  final Future<void> Function() onPressed;
  final Widget child;

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton>
    with LoadingStateMixin, ErrorHandlerMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      child: ElevatedButton(
        autofocus: true,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.secondary,
        ),
        onPressed: () => handleFuture(runWithLoader(widget.onPressed)),
        child: widget.child,
      ),
    );
  }
}
