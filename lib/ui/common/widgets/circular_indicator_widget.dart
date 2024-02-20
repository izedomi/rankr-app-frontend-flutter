import 'package:flutter/material.dart';

import '../../utils/app_color.dart';

class CircularIndicatorWidget extends StatelessWidget {
  const CircularIndicatorWidget({super.key, this.color});
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(color ?? AppColor.stiGreen));
  }
}
