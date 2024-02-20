import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:rankr_app/app/models/participant.dart';
import 'package:rankr_app/app/vm/poll_vm.dart';
import 'package:rankr_app/services/socket_service.dart';
import 'package:rankr_app/ui/common/widgets/close_button_widget.dart';
import 'package:rankr_app/ui/utils/app_color.dart';
import 'package:rankr_app/ui/utils/space.dart';
import '../../../utils/media_query.dart';

class ParticipantBottomSheet extends StatefulWidget {
  const ParticipantBottomSheet({super.key});

  @override
  State<ParticipantBottomSheet> createState() => _ParticipantBottomSheetState();
}

class _ParticipantBottomSheetState extends State<ParticipantBottomSheet> {
  TextEditingController nameController = TextEditingController();
  TextEditingController votePerVoterController =
      TextEditingController(text: "3");
  TextEditingController topicController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<PollVM>(builder: (context, vm, _) {
      return Scaffold(
        backgroundColor: AppColor.white,
        body: SafeArea(
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
                      "Participants",
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
                VSpace(24.h),
                Text(
                  "Poll Topic: ${vm.poll?.topic ?? ""}",
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      height: 1.2),
                ),
                VSpace(30.h),
                Expanded(
                    child: ListView.separated(
                        itemCount: vm.getParticipantsCount(),
                        separatorBuilder: (context, index) {
                          return VSpace(16.h);
                        },
                        itemBuilder: (context, index) {
                          Participant participant = vm.participants()[index];
                          return Container(
                            width: deviceHeight(context),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 8.h),
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              border: Border.all(color: AppColor.white),
                              borderRadius: BorderRadius.circular(4.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 3,
                                  blurRadius: 2,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  participant.name,
                                  style: TextStyle(
                                      color: participant.id == vm.poll?.adminId
                                          ? AppColor.cuzBlue
                                          : AppColor.brandBlack,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                                if (vm.isAdmin() &&
                                    participant.id != vm.user?.sub)
                                  InkWell(
                                      onTap: () {
                                        socketService
                                            .removeParticipant(participant.id);
                                      },
                                      child: const Icon(Iconsax.close_circle))
                              ],
                            ),
                          );
                        }))
              ],
            ),
          ),
        ),
      );
    });
  }
}
