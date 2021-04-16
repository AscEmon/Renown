import 'package:TrainnigInfo/Views/Screens/SubscriptionPage.dart';
import 'package:get/get.dart';
import '../../Views/Screens/HomePage.dart';
import '../../Views/Screens/LoginPage.dart';
import '../../Views/Screens/SignUpPage.dart';
import '../../Views/Screens/SplashPage.dart';
import '../../Views/Screens/NavDrawerScreen/Packages.dart';

class AppRoutes {
  static String INITIAL = "/";
  static String LOGIN = "LoginPage";
  static String SIGNUP = "SignUpPage";
  static String HOMEPAGE = "HomePage";
  static String SUBSCRIPTION = "Subscription";
  static String PACKAGES = "Packages";

  static List<GetPage> AppRoutesList() {
    return [
      GetPage(name: INITIAL, page: () => SplashPage()),
      GetPage(name: LOGIN, page: () => LoginPage()),
      GetPage(name: SIGNUP, page: () => SignUpPage()),
      GetPage(name: HOMEPAGE, page: () => HomePage()),
      GetPage(name: SUBSCRIPTION, page: () => SubscriptionPage()),
      GetPage(name: PACKAGES, page: () => Packages()),
    ];
  }
}
