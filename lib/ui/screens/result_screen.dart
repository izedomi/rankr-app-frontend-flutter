import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rankr_app/app/routes/routes.dart';
import 'package:rankr_app/app/vm/poll_vm.dart';
import 'package:rankr_app/ui/common/widgets/close_button_widget.dart';
import 'package:rankr_app/ui/utils/media_query.dart';
import 'package:rankr_app/ui/utils/space.dart';
import '../../app/models/result.dart';
import '../common/widgets/button_widgets.dart';
import '../utils/app_color.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PollVM>(builder: (context, pollVM, _) {
      return Scaffold(
        bottomSheet: pollVM.pollHasEnded()
            ? Container(
                width: deviceWidth(context),
                height: 60.h,
                //padding: EdgeInsets.only(bottom: 30.h),
                margin: EdgeInsets.symmetric(vertical: 30.h, horizontal: 30.w),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColor.white,
                  border: Border.all(color: AppColor.white),
                  borderRadius: BorderRadius.circular(4.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 3,
                      blurRadius: 2,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "Winner",
                        style: GoogleFonts.montserrat(
                          color: AppColor.brandBlack,
                          fontSize: 15.sp,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: "${pollVM.poll?.results?.first.nominationText}",
                        style: GoogleFonts.montserrat(
                          color: AppColor.cuzBlue,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : pollVM.isAdmin()
                ? Container(
                    padding:
                        EdgeInsets.only(bottom: 30.h, left: 24.w, right: 24.w),
                    child: ButtonWidgets().customButton(
                        buttonColor: AppColor.black,
                        buttonTextColor: AppColor.white,
                        buttonText: "End Poll",
                        context: context,
                        function: () {
                          pollVM.computePollResults();
                          Navigator.pushNamed(context, AppRoute.result);
                        }),
                  )
                : Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 30.h),
                      // child: Text(
                      //   "Waiting for ${pollVM.getPollAdminName()} to close poll",
                      //   style: TextStyle(
                      //       fontSize: 16.sp,
                      //       fontWeight: FontWeight.w500,
                      //       fontStyle: FontStyle.italic,
                      //       height: 1.2),
                      // ),
                      child: RichText(
                        text: TextSpan(
                            text: "Waiting for admin, ",
                            style: GoogleFonts.montserrat(
                              color: AppColor.brandBlack,
                              fontSize: 15.sp,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: "${pollVM.getPollAdminName()} ",
                                style: GoogleFonts.montserrat(
                                    color: AppColor.black,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w600),
                                // navigate to desired screen
                              ),
                              TextSpan(
                                text: 'to close poll',
                                style: GoogleFonts.montserrat(
                                    color: AppColor.brandBlack),
                                // navigate to desired screen
                              ),
                            ]),
                      ),
                    ),
                  ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CloseButtonWidget(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, AppRoute.home, (route) => false);
                  },
                ),
                VSpace(16.h),
                Text(
                  "Results",
                  style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w600,
                      height: 1.2),
                ),
                if (!pollVM.pollHasEnded())
                  Column(
                    children: [
                      VSpace(24.h),
                      Align(
                        alignment: Alignment.centerLeft,
                        // child: Text(
                        //   "1 of 4 participants have voted",
                        //   textAlign: TextAlign.center,
                        //   style: TextStyle(
                        //       fontSize: 18.sp,
                        //       fontWeight: FontWeight.w500,
                        //       height: 1.2),
                        // ),
                        child: RichText(
                          text: TextSpan(
                              text: pollVM.getRankingsCount().toString(),
                              style: GoogleFonts.montserrat(
                                  color: AppColor.cuzBlue,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                              children: <TextSpan>[
                                TextSpan(
                                  text: ' of ',
                                  style: GoogleFonts.montserrat(
                                    color: AppColor.brandBlack,
                                    fontSize: 18,
                                  ),
                                  // navigate to desired screen
                                ),
                                TextSpan(
                                  text:
                                      pollVM.getParticipantsCount().toString(),
                                  style: GoogleFonts.montserrat(
                                      color: AppColor.tRed,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                  // navigate to desired screen
                                ),
                                TextSpan(
                                  text: ' participants have voted',
                                  style: GoogleFonts.montserrat(
                                      color: AppColor.brandBlack, fontSize: 18),
                                  // navigate to desired screen
                                ),
                              ]),
                        ),
                      ),
                      VSpace(30.h),
                    ],
                  ),
                if (pollVM.pollHasEnded())
                  Expanded(
                      child: Column(
                    children: [
                      // const Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Icon(Icons.arrow_back),
                      //     Text(
                      //       "1 of 2",
                      //       style: TextStyle(fontWeight: FontWeight.w600),
                      //     ),
                      //     Icon(Icons.arrow_forward),
                      //   ],
                      // ),
                      VSpace(36.h),
                      Expanded(
                        child: ListView.separated(
                            itemCount: (pollVM.poll?.results?.length ?? 0) + 1,
                            separatorBuilder: (context, index) {
                              return Column(
                                children: [
                                  VSpace(6.h),
                                  const Divider(),
                                  VSpace(6.h),
                                ],
                              );
                            },
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Nomination",
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      "Score",
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                );
                              }
                              Result? result = pollVM.poll?.results![index - 1];
                              if (result != null) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      result.nominationText ?? "",
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      result.score?.toStringAsFixed(4) ?? "",
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 1.8),
                                    ),
                                  ],
                                );
                              }
                              return const SizedBox();
                            }),
                      ),
                    ],
                  )),
              ],
            ),
          ),
        ),
      );
    });
  }
}
