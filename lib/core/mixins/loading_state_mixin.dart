import 'package:flutter/widgets.dart';

mixin LoadingStateMixin<T extends StatefulWidget> on State<T> {
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  Future<void> runWithLoader(Future<void> Function() task) async {
    if (isLoading.value) return;

    isLoading.value = true;
    try {
      await task();
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void dispose() {
    isLoading.dispose();
    super.dispose();
  }
}
