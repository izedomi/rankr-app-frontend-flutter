import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:rankr_app/app/enum/dialog_type.dart';
import 'package:rankr_app/app/routes/routes.dart';
import 'package:rankr_app/app/vm/poll_vm.dart';
import 'package:rankr_app/services/socket_service.dart';
import 'package:rankr_app/ui/common/bs/bs_wrapper.dart';
import 'package:rankr_app/ui/common/bs/content/participant_bottom_sheet.dart';
import 'package:rankr_app/ui/common/dialogs/dialog_content.dart';
import 'package:rankr_app/ui/common/dialogs/dialog_wrapper.dart';
import 'package:rankr_app/ui/common/widgets/back_button_widget.dart';
import 'package:rankr_app/ui/common/widgets/button_widgets.dart';
import 'package:rankr_app/ui/common/bs/content/nomination_bottom_sheet.dart';
import 'package:rankr_app/ui/utils/app_color.dart';
import 'package:rankr_app/ui/utils/media_query.dart';
import 'package:rankr_app/ui/utils/space.dart';

import '../common/bs/content/confirmation_bs.dart';
import '../utils/toast.dart';

class WaitingRoomScreen extends StatefulWidget {
  const WaitingRoomScreen({super.key});

  @override
  State<WaitingRoomScreen> createState() => _WaitingRoomScreenState();
}

class _WaitingRoomScreenState extends State<WaitingRoomScreen> {
  late PollVM pollVM;

  @override
  void initState() {
    super.initState();
    pollVM = context.read<PollVM>();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PollVM>(builder: (context, vm, _) {
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const BackButtonWidget()),
                VSpace(8.h),
                Text(
                  "Waiting Room",
                  style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w600,
                      height: 1.2),
                ),
                Text(
                  "Waiting for admin to start voting",
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColor.wiBlack.withOpacity(0.5)),
                ),
                VSpace(50.h),
                Text(
                  "Poll Topic",
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      height: 1.2),
                ),
                VSpace(6.h),
                Text(
                  vm.poll?.topic ?? "",
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColor.wiBlack.withOpacity(0.8)),
                ),
                VSpace(24.w),
                Text(
                  "Poll ID",
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      height: 1.2),
                ),
                VSpace(6.h),
                GestureDetector(
                  onTap: () async {
                    try {
                      await Clipboard.setData(
                          ClipboardData(text: vm.poll?.id ?? ""));
                      Flush.toast(
                          message: "Poll ID copied successfully",
                          backgroundColor: AppColor.stiGreen);
                    } catch (e) {
                      Flush.toast(message: "Unable to copy poll ID");
                    }
                  },
                  child: Row(
                    children: [
                      Text(
                        vm.poll?.id ?? "",
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w900,
                            color: AppColor.cuzBlue),
                      ),
                      HSpace(30.w),
                      const Icon(
                        Iconsax.copy,
                        color: AppColor.stiGreen,
                      ),
                      HSpace(4.w),
                      Text(
                        "Copy poll ID",
                        style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColor.wiBlack),
                      ),
                    ],
                  ),
                ),
                VSpace(120.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        BsWrapper.bottomSheet(
                            context: context,
                            widget: const ParticipantBottomSheet());
                      },
                      child: Container(
                        width: 50.w,
                        padding: EdgeInsets.symmetric(
                            horizontal: 4.w, vertical: 8.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.r),
                            border: Border.all(color: AppColor.huelYellow)),
                        child: Column(
                          children: [
                            const Icon(Iconsax.people,
                                color: AppColor.huelYellow),
                            VSpace(4.h),
                            Text(
                              vm.getParticipantsCount().toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: AppColor.huelYellow),
                            )
                          ],
                        ),
                      ),
                    ),
                    HSpace(16.w),
                    InkWell(
                      onTap: () {
                        //  Navigator.pushNamed(context, AppRoute.nomination);
                        BsWrapper.bottomSheet(
                            context: context,
                            widget: const NominationBottomSheet());
                      },
                      child: Container(
                        width: 50.w,
                        padding: EdgeInsets.symmetric(
                            horizontal: 4.w, vertical: 8.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.r),
                            border: Border.all(color: AppColor.cuzBlue)),
                        child: Column(
                          children: [
                            const Icon(Iconsax.edit_2, color: AppColor.cuzBlue),
                            VSpace(4.h),
                            Text(
                              vm.getNominationsCount().toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: AppColor.cuzBlue),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const Spacer(),
                vm.isAdmin()
                    ? Align(
                        alignment: Alignment.center,
                        child: Text(
                          getPrompt(vm),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic,
                              color: AppColor.brandBlack),
                        ),
                      )
                    : Align(
                        alignment: Alignment.center,
                        child: RichText(
                          text: TextSpan(
                              text: "Waiting for admin, ",
                              style: GoogleFonts.montserrat(
                                color: AppColor.brandBlack,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.italic,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: vm.getPollAdminName(),
                                  style: GoogleFonts.montserrat(
                                      color: AppColor.brandBlack,
                                      fontSize: 14.sp,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold),
                                  // navigate to desired screen
                                ),
                                TextSpan(
                                  text: " to start poll",
                                  style: GoogleFonts.montserrat(
                                    color: AppColor.brandBlack,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.italic,
                                  ),
                                  // navigate to desired screen
                                ),
                              ]),
                        ),
                      ),
                VSpace(6.h),
                if (vm.isAdmin())
                  Align(
                    alignment: Alignment.center,
                    child: ButtonWidgets().customButton(
                        buttonWidth: deviceWidth(context),
                        context: context,
                        buttonText: vm.poll?.hasStarted == false
                            ? "Start Poll"
                            : "Join Poll",
                        isActive: vm.canStartPoll(),
                        function: () async {
                          // Navigator.pushNamed(context, AppRoute.voting);
                          if (vm.canStartPoll()) {
                            socketService.startPoll();
                          }
                        },
                        buttonTextColor: AppColor.white,
                        buttonColor: AppColor.black),
                  ),
                if (vm.isAdmin()) VSpace(12.h),
                Align(
                  alignment: Alignment.center,
                  child: ButtonWidgets().outlineButton(
                    buttonWidth: deviceWidth(context),
                    context: context,
                    buttonText: vm.isAdmin() ? "Cancel Poll" : "Leave Poll",
                    function: () async {
                      BsWrapper.bottomSheet(
                          context: context,
                          widget: ConfirmationBs(
                              title: vm.isAdmin()
                                  ? "Are you sure you want to cancel this poll?"
                                  : "Are you sure you want to leave poll",
                              onContinue: () {
                                cancelOrLeavePoll();
                              }));
                    },
                    textColor: AppColor.black,
                    outlineColor: AppColor.black,
                  ),
                ),
                VSpace(30.h)
              ],
            ),
          ),
        ),
      );
    });
  }

  String getPrompt(PollVM vm) {
    if (vm.isAdmin() && !vm.canStartPoll()) {
      return "2 Participants & 3 Nominations required to start";
    }
    if (!vm.isAdmin() && vm.poll?.hasStarted != true) {
      return "Waiting for admin, ${vm.getPollAdminName()} to start poll";
    }
    return "";
  }

  showConfirmationDialog() {
    showCustomDialog(context,
        child: confirmationDialog(
            description: "Do you want to continue?",
            title: "Do you want to continue?",
            context: context,
            dialogType: DialogType.info,
            onTapCancel: () {
              Navigator.pop(context);
            },
            onTapContinue: () {}));
  }

  cancelOrLeavePoll() {
    if (pollVM.isAdmin()) {
      socketService.deletePoll();
      return;
    }

    socketService.leavePoll();
    Navigator.pushNamedAndRemoveUntil(context, AppRoute.home, (route) => false);
  }
}
