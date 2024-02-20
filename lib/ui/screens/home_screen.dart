import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rankr_app/app/routes/routes.dart';
import 'package:rankr_app/ui/common/widgets/button_widgets.dart';
import 'package:rankr_app/ui/utils/app_color.dart';
import 'package:rankr_app/ui/utils/media_query.dart';
import 'package:rankr_app/ui/utils/space.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController votePerVoterController = TextEditingController();
  TextEditingController topicController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              VSpace(80.h),
              Text(
                "Welcome to Rankr",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              ButtonWidgets().customButton(
                  context: context,
                  buttonColor: AppColor.brandBlack,
                  buttonTextColor: AppColor.white,
                  buttonText: "Create New Poll",
                  function: () async {
                    Navigator.pushNamed(context, AppRoute.createPoll);
                  }),
              VSpace(16.h),
              ButtonWidgets().outlineButton(
                  context: context,
                  buttonWidth: deviceWidth(context),
                  outlineColor: AppColor.black,
                  textColor: AppColor.black,
                  buttonText: "Join Existing Poll",
                  function: () async {
                    Navigator.pushNamed(context, AppRoute.joinPoll);
                  }),
              VSpace(60.h),
            ],
          ),
        ),
      ),
    );
  }
}
