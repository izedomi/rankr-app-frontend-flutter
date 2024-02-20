import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rankr_app/app/routes/routes.dart';
import 'package:rankr_app/ui/utils/app_color.dart';
import 'package:rankr_app/ui/utils/media_query.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoute.home, (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.brandBlack,
      body: SafeArea(
        child: SizedBox(
          width: deviceWidth(context),
          height: deviceHeight(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Welcome to Rankr",
                style: TextStyle(
                    color: AppColor.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
