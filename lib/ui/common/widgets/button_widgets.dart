import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/app_color.dart';
import '../../utils/space.dart';
import 'circular_indicator_widget.dart';

class ButtonWidgets {
  Widget gradientButton({
    required BuildContext context,
    required Function function,
    double? buttonHeight,
    double? buttonWidth,
    double? buttonTextSize,
    Color? buttonColor,
    String? buttonText,
    Color? buttonTextColor,
    IconData? icon,
    double? radius,
    bool isActive = true,
  }) {
    return InkWell(
      onTap: () {
        if (isActive) {
          function();
        }
      },
      child: Container(
        height: buttonHeight ?? 56.h,
        width: buttonWidth ?? double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius ?? 5.r),
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xffA3CB00), Color(0xffDDDA4C)],
            )),
        child: Text(buttonText ?? "Continue",
            style: TextStyle(
                color: isActive
                    ? buttonTextColor ?? AppColor.black
                    : AppColor.fomoGrey,
                fontSize: buttonTextSize ?? 17.sp,
                fontWeight: FontWeight.w600)),
      ),
    );
    // return SizedBox(
    //   height: buttonHeight ?? 56.h,
    //   width: buttonWidth ?? double.infinity,
    //   child: ElevatedButton(
    //       style: ElevatedButton.styleFrom(
    //           elevation: 0,
    //           backgroundColor:
    //               isActive ? buttonColor ?? AppColor.brandGreen : AppColor.gray,
    //           shadowColor: Colors.black.withOpacity(0.16),
    //           shape: RoundedRectangleBorder(
    //               borderRadius:
    //                   BorderRadius.all(Radius.circular(radius ?? 5.r)))),
    //       onPressed: () {
    //         if (isActive) {
    //           function();
    //         }
    //       },
    //       child: Text(buttonText ?? 'Continue',
    //           style: TextStyle(
    //               color: isActive
    //                   ? buttonTextColor ?? AppColor.black
    //                   : AppColor.fomoGrey,
    //               fontSize: buttonTextSize ?? 17.sp,
    //               fontWeight: FontWeight.w500))),
    // );
  }

  Widget customButton(
      {required BuildContext context,
      required Function function,
      double? buttonHeight,
      double? buttonWidth,
      double? buttonTextSize,
      Color? buttonColor,
      String? buttonText,
      Color? buttonTextColor,
      IconData? icon,
      double? radius,
      bool isActive = true,
      bool isLoading = false,
      String? fontFamily}) {
    return SizedBox(
      height: buttonHeight ?? 50.h,
      width: buttonWidth ?? double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor:
                  isActive ? buttonColor ?? AppColor.brandGreen : AppColor.gray,
              shadowColor: Colors.black.withOpacity(0.16),
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(radius ?? 5.r)))),
          onPressed: () {
            if (isActive) {
              function();
            }
          },
          child: isLoading
              ? const CircularIndicatorWidget()
              : Text(buttonText ?? 'Continue',
                  style: TextStyle(
                      color: isActive
                          ? buttonTextColor ?? AppColor.black
                          : AppColor.fomoGrey,
                      fontSize: buttonTextSize ?? 17.sp,
                      fontFamily: fontFamily,
                      fontWeight: FontWeight.w500))),
    );
  }

  Widget outlineButton(
      {required BuildContext context,
      required Function function,
      double? buttonHeight,
      double? buttonWidth,
      double? buttonTextSize,
      Color? buttonColor,
      Color? textColor,
      FontWeight? fontWeight,
      String? buttonText,
      Color? outlineColor,
      IconData? icon,
      double? radius,
      String? fontFamily}) {
    return SizedBox(
      height: buttonHeight ?? 50.h,
      width: buttonWidth,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: buttonColor ?? Colors.transparent,
            side: BorderSide(width: 1, color: outlineColor ?? AppColor.white),
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(radius ?? 5.r)))),
        onPressed: () {
          function();
        },
        child: Text(
          buttonText ?? 'Proceed',
          style: TextStyle(
            fontSize: buttonTextSize ?? 17.sp,
            fontWeight: fontWeight ?? FontWeight.w500,
            fontFamily: fontFamily,
            color: textColor,
          ),
        ),
      ),
    );
  }

  static customButtonWithImgIcon({
    required BuildContext context,
    required Function function,
    double? buttonHeight,
    double? buttonWidth,
    double? buttonTextSize,
    Color? buttonColor,
    String? buttonText,
    Color? buttonTextColor,
    IconData? icon,
    double? radius,
    bool isActive = true,
    required String imgPath,
  }) {
    return SizedBox(
      height: buttonHeight ?? 56.h,
      width: buttonWidth ?? 219.w,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor:
                isActive ? buttonColor : AppColor.inputGrey.withOpacity(0.4),
            shadowColor: Colors.black.withOpacity(0.16),
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(radius ?? 55.r)))),
        onPressed: () {
          if (isActive) {
            function();
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 20.w,
              height: 16.h,
              child: Image.asset(imgPath),
            ),
            HSpace(12.w),
            Text(
              buttonText ?? 'Capture',
              style: TextStyle(
                color: isActive
                    ? buttonTextColor ?? AppColor.white
                    : const Color(0xff555555),
                fontSize: buttonTextSize ?? 17.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static customTextButton({
    required String text,
    Color? textColor,
    VoidCallback? onPressed,
    FontWeight? fontWeight,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(
          text,
          style: TextStyle(
            color: textColor ?? AppColor.brandGreen,
            fontSize: 14.sp,
            fontWeight: fontWeight ?? FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
