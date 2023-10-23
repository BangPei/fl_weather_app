import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/service/auth_firebase.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthFirebase.authState,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          context.go("/");
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          context.go("/auth");
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
