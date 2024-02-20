import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../app/enum/dialog_type.dart';
import '../../../app/constants/png_image_asset.dart';
import '../../utils/app_color.dart';
import '../../utils/space.dart';
import '../widgets/button_widgets.dart';
import 'package:lottie/lottie.dart';

Widget confirmationDialog(
    {String? header,
    String? title,
    required String description,
    required BuildContext context,
    required DialogType dialogType,
    bool showImage = true,
    bool isLaunchUrl = false,
    String? linkLabel,
    dynamic linkUrl,
    String? subTitle,
    String? imgUrl,
    String? continueLabel,
    String? cancelLabel,
    double? imageWidth,
    double? imageHeight,
    BoxFit? boxFit,
    double? labelSize,
    Function? onTapContinue,
    Function()? onTapCancel,
    double? descriptionFontSize,
    double? titleFontSize,
    Color? descriptionColor}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      VSpace(20.h),
      // statusIcon(dialogType, imgUrl, width: imageWidth, height: imageHeight),
      VSpace(13.h),
      title != null
          ? Text(
              title,
              style: TextStyle(
                  fontSize: 18.h, fontWeight: FontWeight.w600, height: 1.2),
              textAlign: TextAlign.center,
            )
          : const SizedBox(),
      SizedBox(height: 19.h),
      onTapContinue != null
          ? ButtonWidgets().customButton(
              context: context,
              buttonHeight: 48.h,
              radius: 12.r,
              buttonTextSize: 15.sp,
              function: onTapContinue,
              buttonText: continueLabel,
              buttonTextColor: AppColor.white,
              buttonColor: AppColor.dialogBtnColor)
          : const SizedBox(),
      SizedBox(height: 16.h),
    ],
  );
}

statusIcon(DialogType status, String? imgUrl, {double? width, double? height}) {
  double mHeight = width ?? 120.h;
  double mWidth = height ?? 120.w;
  if (imgUrl != null) {
    return SizedBox(
      height: mHeight,
      width: mWidth,
      child: imgUrl.contains(".json")
          ? Lottie.asset(imgUrl, fit: BoxFit.fill)
          : Image.asset(
              imgUrl,
              fit: BoxFit.contain,
              width: width,
              height: height,
            ),
    );
  }
  if (status == DialogType.success) {
    return Image.asset(
      PngImageAsset.logo,
      height: 200,
    );
  }
  if (status == DialogType.error) {
    return Image.asset(
      PngImageAsset.logo,
      height: 120,
    );
  }
  if (status == DialogType.info) {
    return Image.asset(
      PngImageAsset.logo,
      height: 150,
    );
  }
}
