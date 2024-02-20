import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rankr_app/ui/utils/media_query.dart';
import '../../main.dart';
import 'app_color.dart';
import 'space.dart';

class Flush {
  static toast(
      {required String message,
      Color? textColor,
      Color? backgroundColor,
      int? duration,
      FlushbarPosition? position}) {
    return Flushbar<dynamic>(
      messageText: SizedBox(
        width: deviceWidth(navigatorKey.currentContext!),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Iconsax.information5,
              color: AppColor.white,
              size: 24.w,
            ),
            HSpace(8.w),
            Flexible(
              child: Text(
                message,
                maxLines: 2,
                style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: AppColor.white,
                    fontSize: 12.sp,
                    height: 1.4,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: backgroundColor ?? AppColor.red,
      borderRadius: BorderRadius.circular(5.r),
      flushbarPosition: position ?? FlushbarPosition.TOP,
      margin: EdgeInsets.only(
        left: 20.h,
        bottom: 20.h,
        right: 12.w,
      ),
      duration: Duration(seconds: duration ?? 5),
    ).show(navigatorKey.currentContext!);
  }
}
