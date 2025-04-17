import 'package:flutter/material.dart';

void showSnackBar({required BuildContext context, required String message}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
      margin: EdgeInsets.all(20),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      content: Row(
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(color: Colors.white),
          ),
          SizedBox(width: 20),
          Text(message, style: TextStyle(color: Colors.white)),
        ],
      ),
    ),
  );
}
