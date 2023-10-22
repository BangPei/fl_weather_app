import 'package:flutter/material.dart';

class DecorationText {
  DecorationText._();
  static InputDecoration box({String? hintText}) {
    return InputDecoration(
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      fillColor: Colors.grey.shade200,
      filled: true,
      hintText: hintText ?? "",
      hintStyle: TextStyle(
        color: Colors.grey[500],
      ),
    );
  }
}
