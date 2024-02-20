import 'package:flutter/material.dart';

class BsWrapper {
  static void bottomSheet({
    required BuildContext context,
    required Widget widget,
    isScrollControlled = true,
    bool? canDismiss,
    double? topRadius,
    Color? color,
  }) {
    showModalBottomSheet(
      backgroundColor: color ?? Colors.white,
      isScrollControlled: true,
      isDismissible: canDismiss ?? true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topRadius ?? 20),
          topRight: Radius.circular(topRadius ?? 20),
        ),
      ),
      context: context,
      builder: (BuildContext bc) {
        return widget;
      },
    );
  }
}
