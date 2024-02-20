import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import '../../../utils/app_color.dart';
import '../../../utils/space.dart';
import '../../widgets/button_widgets.dart';

class ConfirmationBs extends StatefulWidget {
  final Function() onContinue;
  final String? title;

  const ConfirmationBs({Key? key, required this.onContinue, this.title})
      : super(key: key);

  @override
  State<ConfirmationBs> createState() => _ConfirmationBsState();
}

class _ConfirmationBsState extends State<ConfirmationBs> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(top: 16.h, bottom: 56.h, left: 24.w, right: 24.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: Text(
                "Close",
                style: TextStyle(
                    fontSize: 15.sp,
                    color: AppColor.brandBlack.withOpacity(0.6)),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(height: 24.h),
          mainContent()
        ],
      ),
    );
  }

  Widget mainContent() {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Icon(
        Iconsax.info_circle,
        color: AppColor.pendingOrange,
        size: 50.sp,
      ),
      VSpace(20.h),
      Text(widget.title ?? "Are you sure you want to continue?",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17.sp)),
      VSpace(36.h),
      ButtonWidgets().customButton(
        context: context,
        buttonColor: AppColor.brandBlack,
        buttonTextColor: AppColor.white,
        buttonText: "Yes, Continue",
        function: widget.onContinue,
      ),
      VSpace(16.h),
      InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Text("No, Cancel",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 17.sp,
                color: AppColor.brandBlack)),
      )
    ]);
  }
}
