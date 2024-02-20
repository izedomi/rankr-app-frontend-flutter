import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rankr_app/app/routes/routes.dart';
import 'package:rankr_app/ui/common/helpers/custom_textfield_widget.dart';
import 'package:rankr_app/ui/common/widgets/back_button_widget.dart';
import 'package:rankr_app/ui/common/widgets/button_widgets.dart';
import 'package:rankr_app/ui/utils/app_color.dart';
import 'package:rankr_app/ui/utils/space.dart';
import '../../app/enum/viewstate.dart';
import '../../app/vm/poll_vm.dart';
import '../utils/toast.dart';

class JoinPollScreen extends StatefulWidget {
  const JoinPollScreen({super.key});

  @override
  State<JoinPollScreen> createState() => _JoinPollScreenState();
}

class _JoinPollScreenState extends State<JoinPollScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Align(
                  alignment: Alignment.centerLeft, child: BackButtonWidget()),
              VSpace(8.h),
              Text(
                "Join Poll",
                style: TextStyle(
                    fontSize: 30.sp, fontWeight: FontWeight.w600, height: 1.2),
              ),
              Text(
                "Enter Code Provided by Friend",
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColor.wiBlack.withOpacity(0.5)),
              ),
              VSpace(100.h),
              CustomTextField(
                  labelText: "Enter Poll ID",
                  controller: codeController,
                  onChange: () => setState(() {})),
              VSpace(24.h),
              CustomTextField(
                  labelText: "Your Name",
                  controller: nameController,
                  onChange: () => setState(() {})),
              VSpace(24.h),
              // const Spacer(),
              // Consumer<PollVM>(builder: (context, vm, _) {
              //   return ButtonWidgets().customButton(
              //       context: context,
              //       buttonColor: AppColor.brandBlack,
              //       buttonTextColor: AppColor.white,
              //       buttonText: "Join",
              //       isActive: formIsValid() &&
              //           vm.createPollViewState != ViewState.busy,
              //       isLoading: vm.createPollViewState == ViewState.busy,
              //       function: joinPoll);
              // }),
              // VSpace(60.h),
            ],
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
              buttonText: "Join",
              isActive:
                  formIsValid() && vm.createPollViewState != ViewState.busy,
              isLoading: vm.createPollViewState == ViewState.busy,
              function: joinPoll);
        }),
      ),
    );
  }

  joinPoll() async {
    final vm = Provider.of<PollVM>(context, listen: false);
    final res = await vm.createOrJoinPoll(
        {"name": nameController.text, "pollID": codeController.text}, false);

    //voting has started
    if (res.first == 205) {
      gotoVotingScreen();
      return;
    }

    //voting has ended
    if (res.first == 206) {
      gotoResultScreen();
      Flush.toast(message: res.last, backgroundColor: AppColor.stiGreen);
      return;
    }

    if (res.first == 200 || res.first == 201) {
      gotoWaitingRoom();
      return;
    }

    Flush.toast(message: res.last);
  }

  gotoWaitingRoom() {
    Navigator.pushNamed(context, AppRoute.waitingRoom);
  }

  gotoVotingScreen() {
    Navigator.pushNamed(context, AppRoute.voting);
  }

  gotoResultScreen() {
    Navigator.pushNamed(context, AppRoute.result);
  }

  formIsValid() {
    return nameController.text.isNotEmpty && codeController.text.isNotEmpty;
  }
}
