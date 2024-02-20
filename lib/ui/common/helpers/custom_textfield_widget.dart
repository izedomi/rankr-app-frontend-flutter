import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import '../../../app/enum/keyboard_type.dart';
import '../../utils/app_color.dart';
import '../../utils/space.dart';
import '../../utils/textfield_utils.dart';

class CustomTextField extends StatefulWidget {
  final String labelText;
  final String? hintText;
  final String? optionalText;
  final TextEditingController controller;
  final Function? onChange;
  final bool? isPassword;
  final bool? isConfirmPassword;
  final bool? showSuffixIcon;
  final Widget? suffixIcon;
  final Widget? prefix;
  final String? errorText;
  final KeyboardType keyboardType;
  final double? width;
  final double? height;
  final bool? isReadOnly;
  final FocusNode? focusNode;
  final bool showLabelHeader;
  final Color? labelColor;
  final double? labelSize;
  final bool isOptional;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final int? maxLines;
  final TextCapitalization? capitalization;
  final Function()? onTap;
  final bool isFilled;
  final Color filledColor;
  final Color? textColor;

  const CustomTextField(
      {Key? key,
      required this.labelText,
      this.hintText,
      this.optionalText,
      this.labelColor,
      this.labelSize,
      required this.controller,
      this.isPassword = false,
      this.isConfirmPassword = false,
      this.showSuffixIcon = false,
      this.suffixIcon,
      this.prefix,
      this.errorText,
      this.width,
      this.height,
      this.maxLines,
      this.isReadOnly = false,
      this.keyboardType = KeyboardType.regular,
      this.showLabelHeader = true,
      this.focusNode,
      this.isOptional = false,
      this.onChange,
      this.labelStyle,
      this.hintStyle,
      this.capitalization,
      this.onTap,
      this.isFilled = false,
      this.textColor,
      this.filledColor = Colors.transparent})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool showPassword = false;
  double radius = 8.r;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String? validatePassword(String value) {
    if (!(value.length > 5) && value.isNotEmpty) {
      return "Password should contain more than 5 characters";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   height: 60.h,
    //   child: TextFormField(
    //     controller: widget.controller,
    //     obscureText: true,
    //     decoration: InputDecoration(
    //       prefixIcon: Icon(Icons.lock_open, color: Colors.grey),
    //       hintText: 'Confirm Password',
    //       errorText: "elwj",
    //       //errorText: validatePassword(widget.controller.text),
    //       contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
    //       enabledBorder: OutlineInputBorder(
    //         // borderSide: BorderSide.none,
    //         borderSide: const BorderSide(color: Color(0xffE0E0E0)),
    //         borderRadius: BorderRadius.circular(radius),
    //       ),
    //       disabledBorder: OutlineInputBorder(
    //         borderSide: const BorderSide(color: Color(0xffE0E0E0)),
    //         borderRadius: BorderRadius.circular(radius),
    //       ),
    //       border: OutlineInputBorder(
    //         borderSide: const BorderSide(color: Color(0xffE0E0E0)),
    //         borderRadius: BorderRadius.circular(radius),
    //       ),
    //       focusedErrorBorder: OutlineInputBorder(
    //         borderSide: const BorderSide(color: Color(0xff94C358)),
    //         borderRadius: BorderRadius.circular(radius),
    //       ),
    //       focusedBorder: OutlineInputBorder(
    //         borderSide: const BorderSide(color: Color(0xff94C358)),
    //         borderRadius: BorderRadius.circular(radius),
    //       ),
    //     ),
    //   ),
    // );
    return SizedBox(
      width: widget.width ?? double.infinity,
      // height: widget.height ?? 60.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            //cursorHeight: 14.sp,
            cursorColor: AppColor.black,
            focusNode: widget.focusNode,
            maxLines: widget.maxLines ?? 1,
            style: TextStyle(
                color: widget.textColor ?? AppColor.wiBlack,
                fontSize: 16.sp,
                // fontFamily: poppins,
                fontWeight: FontWeight.w400),

            controller: widget.controller,
            obscureText: widget.isPassword! && !showPassword,
            obscuringCharacter: "●".toString().substring(0, 1),
            keyboardType: inputType(widget.keyboardType),
            inputFormatters: inputFormatter(widget.keyboardType),
            textCapitalization:
                widget.capitalization ?? TextCapitalization.none,
            onChanged: (String value) {
              if (widget.onChange != null) {
                widget.onChange!();
              }
            },

            onTap: widget.onTap,
            readOnly: widget.isReadOnly!,
            decoration: InputDecoration(
              fillColor: widget.filledColor,
              filled: widget.isFilled,
              prefixIcon: widget.prefix,
              errorText: widget.errorText,
              errorStyle: TextStyle(
                  color: AppColor.red, fontSize: 0.01.sp, height: 0.2),
              hintText: widget.hintText,
              hintStyle: widget.hintStyle ??
                  TextStyle(
                    color: widget.labelColor ?? AppColor.gray,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
              labelText: widget.labelText,
              suffixIcon: widget.showSuffixIcon!
                  ? Container(
                      padding: EdgeInsets.only(
                        right: 16.w,
                      ),
                      child: widget.suffixIcon ?? suffixIcon(),
                    )
                  : const SizedBox.shrink(),
              labelStyle: widget.labelStyle ??
                  TextStyle(
                      color: AppColor.fomoGrey,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      height: 1.3),
              enabledBorder: OutlineInputBorder(
                // borderSide: BorderSide.none,
                borderSide: const BorderSide(color: Color(0xffE0E0E0)),
                borderRadius: BorderRadius.circular(radius),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xffE0E0E0)),
                borderRadius: BorderRadius.circular(radius),
              ),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xffE0E0E0)),
                borderRadius: BorderRadius.circular(radius),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xff94C358)),
                borderRadius: BorderRadius.circular(radius),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xff94C358)),
                borderRadius: BorderRadius.circular(radius),
              ),
            ),
          ),
          VSpace(1.h),
          if (widget.errorText != null)
            Text(
              widget.errorText!,
              textAlign: TextAlign.left,
              style: TextStyle(color: AppColor.red, fontSize: 11.sp),
            )
        ],
      ),
    );
  }

  Widget? suffixIcon() {
    if (widget.isPassword! && !widget.isConfirmPassword!) {
      return GestureDetector(
          onTap: () => setState(() {
                showPassword = !showPassword;
              }),
          child: PasswordSuffixWidget(
            showPassword: showPassword,
          ));
    }
    if (widget.showSuffixIcon! && widget.suffixIcon == null) {
      return Icon(Iconsax.arrow_down,
          size: 18, color: AppColor.gray.withOpacity(0.7));
    }

    if (widget.showSuffixIcon! && widget.suffixIcon != null) {
      //return const Icon(FontAwesomeIcons.circleCheck, size: 16, color: green);
      return widget.suffixIcon;
    }
    return null;
  }
}

class PasswordSuffixWidget extends StatelessWidget {
  final bool showPassword;
  const PasswordSuffixWidget({super.key, required this.showPassword});

  @override
  Widget build(BuildContext context) {
    return showPassword
        ? const Icon(
            Iconsax.eye,
            color: AppColor.fomoGrey,
          )
        : const Icon(
            Iconsax.eye_slash,
            color: AppColor.fomoGrey,
          );
  }
}
