import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rankr_app/locator.dart';
import 'app/env/env.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app/routes/router.dart';
import 'app/routes/routes.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Env().init(Env.dev);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(393, 845.33),
        builder: (context, child) {
          return MultiProvider(
            providers: allProviders,
            child: MaterialApp(
              title: 'Rankr App',
              navigatorKey: navigatorKey,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  colorScheme:
                      ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                  useMaterial3: false,
                  textTheme: GoogleFonts.montserratTextTheme(),
                  bottomSheetTheme: const BottomSheetThemeData(
                      backgroundColor: Colors.transparent)),
              initialRoute: AppRoute.splash,
              onGenerateRoute: AppRouter.generateRoute,
            ),
          );
        });
  }
}
