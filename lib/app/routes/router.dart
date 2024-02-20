import 'package:flutter/material.dart';
import 'package:rankr_app/ui/screens/create_poll_screen.dart';
import 'package:rankr_app/ui/screens/home_screen.dart';
import 'package:rankr_app/ui/screens/join_poll_screen.dart';
import 'package:rankr_app/ui/common/bs/content/nomination_bottom_sheet.dart';
import 'package:rankr_app/ui/screens/voting_screen.dart';
import 'package:rankr_app/ui/screens/waiting_room_screen.dart';
import '../../ui/screens/result_screen.dart';
import '../../ui/screens/splash_screen.dart';
import '../constants/globals.dart';
import 'routes.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // var args = settings.arguments;
    // printty("route: $activeScreen");
    activeRoute = settings.name;
    switch (settings.name) {
      //welcome routes
      case AppRoute.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppRoute.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case AppRoute.createPoll:
        return MaterialPageRoute(builder: (_) => const CreatePollScreen());
      case AppRoute.joinPoll:
        return MaterialPageRoute(builder: (_) => const JoinPollScreen());
      case AppRoute.nomination:
        return MaterialPageRoute(builder: (_) => const NominationBottomSheet());
      case AppRoute.voting:
        return MaterialPageRoute(builder: (_) => const VotingScreen());
      case AppRoute.waitingRoom:
        return MaterialPageRoute(builder: (_) => const WaitingRoomScreen());
      case AppRoute.result:
        return MaterialPageRoute(builder: (_) => const ResultScreen());

      default:
        return errorScreen('No route defined for ${settings.name}');
    }
  }

  static MaterialPageRoute errorScreen(String msg) {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              body: Center(
                child: Text(msg),
              ),
            ));
  }
}
