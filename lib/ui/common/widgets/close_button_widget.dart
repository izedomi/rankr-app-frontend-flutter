import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_color.dart';

class CloseButtonWidget extends StatelessWidget {
  final Function()? onTap;
  const CloseButtonWidget({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ??
          () {
            Navigator.pop(context);
          },
      child: Container(
        width: 30.w,
        height: 35.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            //  borderRadius: BorderRadius.circular(8.r),
            shape: BoxShape.circle,
            border: Border.all(color: AppColor.black)),
        child: const Icon(
          Icons.close,
          color: AppColor.bakoBlack,
          size: 20,
        ),
      ),
    );
  }
}
