import 'package:flutter/material.dart';
import 'package:weather_app/widget/loading_screen.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoadingScreen(),
    );
  }
}
