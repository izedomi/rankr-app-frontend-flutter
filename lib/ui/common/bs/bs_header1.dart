// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_color.dart';
import '../../utils/space.dart';

class BsHeader1 extends StatelessWidget {
  const BsHeader1(
      {Key? key,
      required this.navTitle,
      this.rightIconWidget,
      this.titleFontSize,
      this.titleColor})
      : super(key: key);

  final String navTitle;
  final Widget? rightIconWidget;

  final double? titleFontSize;
  final Color? titleColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Align(
        //   alignment: Alignment.centerRight,
        //   child: InkWell(
        //     onTap: () => Navigator.pop(context),
        //     child: Text(
        //       "Close",
        //       style: TextStyle(
        //           fontSize: 15.sp, color: AppColor.brandBlack.withOpacity(0.6)),
        //       textAlign: TextAlign.center,
        //     ),
        //   ),
        // ),
        VSpace(22.h),
        Container(
          width: 72.w,
          height: 5.h,
          decoration: BoxDecoration(
              color: AppColor.bsDivider,
              borderRadius: BorderRadius.circular(4.r)),
        ),
        VSpace(21.h),
        Text(navTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColor.brandBlack,
              fontSize: 17.sp,
            )),
      ],
    );
  }
}
