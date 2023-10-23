import 'package:flutter/material.dart';

class Common {
  Common._();

  static Future<bool> onWillPop(BuildContext context) async {
    final value = await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: const Text('Are you sure you want to exit?'),
            actions: <Widget>[
              TextButton(
                child: const Text('No'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                child: const Text('Yes, exit'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        });

    return value == true;
  }

  static modalInfo(BuildContext context,
      {String? message, required String title, Icon? icon}) {
    showDialog(
      context: context,
      builder: (__) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const Divider(height: 2, thickness: 3),
                icon ??
                    const Icon(
                      Icons.cancel,
                      color: Colors.red,
                      size: 50,
                    ),
                Text(
                  message ?? "Message",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}
