import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:rankr_app/app/vm/poll_vm.dart';
import 'package:rankr_app/services/socket_service.dart';
import 'package:rankr_app/ui/common/helpers/custom_textfield_widget.dart';
import 'package:rankr_app/ui/common/widgets/button_widgets.dart';
import 'package:rankr_app/ui/utils/app_color.dart';
import 'package:rankr_app/ui/utils/space.dart';
import '../../../../app/models/polls.dart';
import '../../../utils/media_query.dart';
import '../../widgets/close_button_widget.dart';

class NominationBottomSheet extends StatefulWidget {
  const NominationBottomSheet({super.key});

  @override
  State<NominationBottomSheet> createState() => _NominationBottomSheetState();
}

class _NominationBottomSheetState extends State<NominationBottomSheet> {
  TextEditingController nominationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<PollVM>(builder: (context, vm, _) {
      return SizedBox(
        // height: deviceHeight(context) * 0.95,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VSpace(60.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Add Nominations",
                    style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w600,
                        height: 1.2),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: const CloseButtonWidget()),
                  ),
                ],
              ),
              VSpace(50.h),
              Text("Poll Topic: ${vm.poll?.topic ?? ""}",
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      height: 1.2)),
              VSpace(16.h),
              if (vm.poll?.hasStarted == true)
                Column(
                  children: [
                    VSpace(16.h),
                    Text("Nomination is closed. Poll has started.",
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            height: 1.2,
                            color: AppColor.cuzBlue,
                            fontStyle: FontStyle.italic)),
                  ],
                ),
              VSpace(24.h),
              if (vm.poll?.hasStarted != true)
                Column(
                  children: [
                    CustomTextField(
                      labelText: "Enter nomination(Required)",
                      controller: nominationController,
                      onChange: () => setState(() {}),
                    ),
                    VSpace(24.h),
                    Align(
                      alignment: Alignment.center,
                      child: ButtonWidgets().customButton(
                          context: context,
                          buttonColor: AppColor.brandBlack,
                          buttonTextColor: AppColor.white,
                          buttonText: "Nominate",
                          isActive: nominationController.text.isNotEmpty &&
                              nominationController.text.length > 3 &&
                              vm.poll?.hasStarted != true,
                          function: () async {
                            socketService.nominate(nominationController.text);
                            nominationController.clear();
                          }),
                    ),
                  ],
                ),
              VSpace(40.h),
              if (vm.getNominationsCount() > 0)
                Expanded(
                    child: ListView.separated(
                        itemCount: vm.getNominationsCount() + 1,
                        separatorBuilder: (context, index) {
                          return VSpace(16.h);
                        },
                        itemBuilder: (context, index) {
                          // return Text('slfj');
                          if (index == 0) {
                            return Text(
                              "Nominations",
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                  height: 1.2),
                            );
                          }
                          MapEntry<String, Nomination> nomination =
                              vm.nominations()[index - 1];
                          return Container(
                            width: deviceHeight(context),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 8.h),
                            decoration: BoxDecoration(
                              // color: vm.user?.sub == nomination.value.userId
                              //     ? AppColor.vuGrey
                              //     : AppColor.white,
                              color: vm.user?.sub == nomination.value.userId
                                  ? AppColor.cuzBlue.withOpacity(0.1)
                                  : AppColor.white,
                              border: Border.all(
                                  color: vm.user?.sub == nomination.value.userId
                                      ? Colors.transparent
                                      : AppColor.cuzBlue.withOpacity(0.5)),
                              borderRadius: BorderRadius.circular(4.r),
                              // border: Border.all(color: AppColor.white),
                              // boxShadow: [
                              //   BoxShadow(
                              //     color: Colors.grey.withOpacity(0.3),
                              //     spreadRadius: 3,
                              //     blurRadius: 2,
                              //     offset: const Offset(
                              //         0, 3), // changes position of shadow
                              //   ),
                              // ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(nomination.value.name ?? "",
                                    style: TextStyle(
                                        // color: vm.user?.sub ==
                                        //         nomination.value.userId
                                        //     ? AppColor.cuzBlue
                                        //     : AppColor.brandBlack,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500)),
                                if (vm.user?.sub == nomination.value.userId)
                                  InkWell(
                                    onTap: () {
                                      socketService
                                          .removeNomination(nomination.key);
                                    },
                                    child: const Icon(
                                      Iconsax.close_circle,
                                      color: AppColor.red,
                                    ),
                                  )
                              ],
                            ),
                          );
                        }))
            ],
          ),
        ),
      );
    });
  }
}
