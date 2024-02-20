import 'package:flutter/material.dart';

class BaseWidget extends StatelessWidget {
  final Widget child;
  const BaseWidget({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          child,
        ],
      ),
    );
  }
}
