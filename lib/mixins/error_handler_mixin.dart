import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

mixin ErrorHandlerMixin<T extends StatefulWidget> on State<T> {
  Future<C?> handleFuture<C>(Future<C> future) async {
    if (mounted) {
      try {
        return await future;
      } catch (e) {
        showErrorDialog(e.toString());
        if (kDebugMode) {
          print(e);
        }
        return null;
      }
    }
    return null;
  }

  void showErrorDialog(String message) {
    if (mounted) {
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(title: Text('Error'), content: Text(message)),
      );
    }
  }
}
