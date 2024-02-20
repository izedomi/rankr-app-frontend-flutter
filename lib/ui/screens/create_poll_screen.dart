import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rankr_app/app/enum/viewstate.dart';
import 'package:rankr_app/app/routes/routes.dart';
import 'package:rankr_app/ui/common/helpers/custom_textfield_widget.dart';
import 'package:rankr_app/ui/common/widgets/back_button_widget.dart';
import 'package:rankr_app/ui/common/widgets/button_widgets.dart';
import 'package:rankr_app/ui/utils/app_color.dart';
import 'package:rankr_app/ui/utils/media_query.dart';
import 'package:rankr_app/ui/utils/space.dart';
import '../../app/print.dart';
import '../../app/vm/poll_vm.dart';
import '../utils/toast.dart';

class CreatePollScreen extends StatefulWidget {
  const CreatePollScreen({super.key});

  @override
  State<CreatePollScreen> createState() => _CreatePollScreenState();
}

class _CreatePollScreenState extends State<CreatePollScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController votePerVoterController =
      TextEditingController(text: "3");
  TextEditingController topicController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: deviceHeight(context),
          width: deviceWidth(context),
          child: SingleChildScrollView(
            child: SizedBox(
              height: deviceHeight(context),
              width: deviceWidth(context),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BackButtonWidget(),
                    // InkWell(
                    //   // onTap: widget.params?.canPop == false
                    //   //     ? () => SystemNavigator.pop()
                    //   //     : () => Navigator.pop(context),
                    //   child: Container(
                    //     width: 30.w,
                    //     height: 35.w,
                    //     alignment: Alignment.center,
                    //     decoration: BoxDecoration(
                    //         //  borderRadius: BorderRadius.circular(8.r),
                    //         shape: BoxShape.circle,
                    //         border: Border.all(color: AppColor.black)),
                    //     child: const Icon(
                    //       Icons.chevron_left,
                    //       color: AppColor.bakoBlack,
                    //       size: 20,
                    //     ),
                    //   ),
                    // ),
                    VSpace(8.h),
                    Text(
                      "Create Poll",
                      style: TextStyle(
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w600,
                          height: 1.2),
                    ),
                    Text(
                      "Create a poll and invite your friends to participate",
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColor.wiBlack.withOpacity(0.5)),
                    ),
                    VSpace(100.h),
                    CustomTextField(
                        labelText: "Your Name (Required)",
                        controller: nameController,
                        onChange: () => setState(() {})),
                    VSpace(24.h),
                    CustomTextField(
                      labelText: "Enter Poll Topic (Required)",
                      controller: topicController,
                      onChange: () => setState(() {}),
                    ),
                    VSpace(24.h),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Votes per Voter",
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w600),
                      ),
                    ),
                    VSpace(16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                            onTap: () {
                              if (votePerVoterController.text == "1") {
                                return;
                              }
                              votePerVoterController.text =
                                  (int.parse(votePerVoterController.text) - 1)
                                      .toString();
                              setState(() {});
                            },
                            child: _addItem("-")),
                        HSpace(24.w),
                        Container(
                          width: 45.w,
                          padding: EdgeInsets.only(left: 15.w, right: 15.w),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: votePerVoterController,
                            style: TextStyle(
                                fontSize: 24.sp, fontWeight: FontWeight.w600),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            // readOnly: true,
                          ),
                        ),
                        HSpace(24.w),
                        InkWell(
                            onTap: () {
                              if (votePerVoterController.text == "5") {
                                return;
                              }
                              votePerVoterController.text =
                                  (int.parse(votePerVoterController.text) + 1)
                                      .toString();
                              setState(() {});
                            },
                            child: _addItem("+")),
                      ],
                    ),
                    // const Spacer(),

                    //  VSpace(16.h),
                    // ButtonWidgets().outlineButton(
                    //     context: context,
                    //     buttonWidth: deviceWidth(context),
                    //     outlineColor: AppColor.black,
                    //     textColor: AppColor.black,
                    //     buttonText: "Start Over",
                    //     function: () async {}),
                    ///VSpace(60.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        margin: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 24.w),
        child: Consumer<PollVM>(builder: (context, vm, _) {
          return ButtonWidgets().customButton(
              context: context,
              buttonColor: AppColor.brandBlack,
              buttonTextColor: AppColor.white,
              buttonText: "Create",
              isActive:
                  formIsValid() && vm.createPollViewState != ViewState.busy,
              isLoading: vm.createPollViewState == ViewState.busy,
              function: createPoll);
        }),
      ),
    );
  }

  Widget _addItem(String label) {
    return Container(
      width: 40.w,
      height: 40.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          shape: BoxShape.circle, border: Border.all(color: AppColor.stiGreen)),
      child: Text(
        label,
        style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
            color: AppColor.stiGreen),
      ),
    );
  }

  createPoll() async {
    final vm = Provider.of<PollVM>(context, listen: false);
    final res = await vm.createOrJoinPoll({
      "name": nameController.text,
      "votesPerVoter": int.tryParse(votePerVoterController.text) ?? 3,
      "topic": topicController.text
    }, true);
    if (res.first == 200 || res.first == 201) {
      gotoWaitingRoom();
      return;
    }
    printty(res.last);
    Flush.toast(message: res.last);
  }

  gotoWaitingRoom() {
    Navigator.pushNamed(context, AppRoute.waitingRoom);
  }

  formIsValid() {
    return nameController.text.isNotEmpty &&
        votePerVoterController.text.isNotEmpty &&
        topicController.text.isNotEmpty;
  }
}
