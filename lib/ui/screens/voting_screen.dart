import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rankr_app/app/print.dart';
import 'package:rankr_app/app/vm/poll_vm.dart';
import 'package:rankr_app/app/vm/ranking_vm.dart';
import 'package:rankr_app/ui/common/bs/bs_wrapper.dart';
import 'package:rankr_app/ui/common/bs/content/confirmation_bs.dart';
import 'package:rankr_app/ui/common/widgets/back_button_widget.dart';
import 'package:rankr_app/ui/common/widgets/button_widgets.dart';
import 'package:rankr_app/ui/utils/app_color.dart';
import 'package:rankr_app/ui/utils/space.dart';
import '../../app/models/polls.dart';
import '../../app/routes/routes.dart';
import '../utils/media_query.dart';

class VotingScreen extends StatefulWidget {
  const VotingScreen({super.key});

  @override
  State<VotingScreen> createState() => _VotingScreenState();
}

class _VotingScreenState extends State<VotingScreen> {
  late PollVM pollVM;
  int votePerVoter = 0;

  @override
  void initState() {
    super.initState();
    pollVM = context.read<PollVM>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RankingVM>().setRankings(pollVM.nominations());
      pollVM.poll?.rankings.toString();
      votePerVoter = pollVM.poll?.votesPerVoter ?? 0;
      // pollVM.poll?.rankings?.toJson().toString();
      //printty("====-=-2323233");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RankingVM>(builder: (context, vm, _) {
      return Scaffold(
        bottomSheet: Container(
          margin: EdgeInsets.only(left: 24.w, right: 24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ButtonWidgets().customButton(
                  buttonColor: AppColor.black,
                  buttonTextColor: AppColor.white,
                  buttonText: "Submit votes",
                  context: context,
                  function: () {
                    // showCustomDialog(context, child: Text("dss"));
                    BsWrapper.bottomSheet(
                        context: context,
                        widget: ConfirmationBs(
                            title:
                                "Are you sure you want to submit your votes? It cannot be changed once submitted.",
                            onContinue: () {
                              vm.submitRankings(votePerVoter);
                              Navigator.pushNamed(context, AppRoute.result);
                            }));
                  }),
              if (pollVM.isAdmin())
                Column(
                  children: [
                    VSpace(12.h),
                    Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () {
                          BsWrapper.bottomSheet(
                              context: context,
                              widget: ConfirmationBs(
                                  title:
                                      "Are you sure you want to cancel this poll?",
                                  onContinue: () {
                                    pollVM.deletePoll();
                                  }));
                        },
                        child: Text("Cancel Poll",
                            style: TextStyle(
                                color: AppColor.brandBlack,
                                fontSize: 16.sp,
                                decoration: TextDecoration.underline)),
                      ),
                    ),
                  ],
                ),
              VSpace(24.h)
            ],
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const BackButtonWidget()),
                Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Rank your top $votePerVoter Choices?",
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          height: 1.2),
                    )),
                VSpace(24.h),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Drag to reorder selections",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColor.cuzBlue,
                        height: 1.2),
                  ),
                ),
                VSpace(40.h),
                Expanded(
                  child: ReorderableListView.builder(
                    padding: EdgeInsets.only(bottom: 70.h),
                    itemCount: vm.rankings.length,
                    onReorder: ((oldIndex, newIndex) {
                      printty("Old index: $oldIndex");
                      printty("New index: $newIndex");
                      vm.updateRankings(oldIndex, newIndex);
                    }),
                    itemBuilder: (context, index) {
                      MapEntry<String, Nomination> nomination =
                          vm.rankings[index];
                      return Container(
                        key: ValueKey(index.toString()),
                        // padding: EdgeInsets.all(6.w),
                        margin: EdgeInsets.all(0.w),
                        //  color: const Color.fromRGBO(0, 0, 0, 1),
                        child: Stack(
                          children: [
                            Container(
                              width: deviceHeight(context),
                              margin: EdgeInsets.all(10.w),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 8.h),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColor.cuzBlue.withOpacity(0.6)),
                                  borderRadius: BorderRadius.circular(4.r)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(nomination.value.name ?? ""),
                                ],
                              ),
                            ),
                            if (index < votePerVoter)
                              Positioned(
                                right: 8,
                                top: 8,
                                child: Container(
                                  width: 20.w,
                                  height: 20.w,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                      color: AppColor.cardOrange,
                                      shape: BoxShape.circle),
                                  child: Text((index + 1).toString(),
                                      style: const TextStyle(
                                          color: AppColor.white)),
                                ),
                              )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
