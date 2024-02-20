// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_color.dart';

class BsHeader extends StatelessWidget {
  const BsHeader(
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 10,
          child: Text(navTitle,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColor.brandBlack,
                fontSize: 18.sp,
              )),
        ),
        Flexible(
          flex: 2,
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: AppColor.white,
                    border:
                        Border.all(width: 1.sp, color: AppColor.shadowGrey)),
                child: const Icon(Icons.close)),
          ),
        )
      ],
    );
  }
}
