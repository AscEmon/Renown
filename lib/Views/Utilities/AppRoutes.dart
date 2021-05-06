import 'package:TrainnigInfo/Views/Screens/Admin/AdminPackages/AdminPackagesGet.dart';
import 'package:TrainnigInfo/Views/Screens/Admin/AdminPackages/AdminPackagesPost.dart';
import 'package:TrainnigInfo/Views/Screens/Admin/AdminVideo/AdminVideoPost.dart';
import 'package:TrainnigInfo/Views/Screens/Admin/Dashboard.dart';
import 'package:TrainnigInfo/Views/Screens/ForumModule/CommentPage.dart';
import 'package:TrainnigInfo/Views/Screens/ForumModule/FoumPage.dart';
import 'package:TrainnigInfo/Views/Screens/ForumModule/StatusPage.dart';
import 'package:TrainnigInfo/Views/Screens/Admin/TotalUser.dart';
import 'package:TrainnigInfo/Views/Screens/NavDrawerScreen/LiveChatWebView.dart';
import 'package:TrainnigInfo/Views/Screens/NavDrawerScreen/PreviousActivity.dart';
import 'package:TrainnigInfo/Views/Screens/PaymentWebView.dart';
import 'package:TrainnigInfo/Views/Screens/UserHomePage.dart';
import 'package:TrainnigInfo/Views/Screens/PicturePage.dart';
import 'package:TrainnigInfo/Views/Screens/SubscriptionPage.dart';
import 'package:get/get.dart';
import '../../Views/Screens/Admin/AdminHomePage.dart';
import '../../Views/Screens/LoginPage.dart';
import '../../Views/Screens/SignUpPage.dart';
import '../../Views/Screens/SplashPage.dart';
import '../../Views/Screens/NavDrawerScreen/Packages.dart';

class AppRoutes {
  static String INITIAL = "/";
  static String LOGIN = "LoginPage";
  static String SIGNUP = "SignUpPage";
  static String HOMEPAGE = "AdminHomePage";
  static String SUBSCRIPTION = "Subscription";
  static String PACKAGES = "Packages";
  static String LIVECHATWEBVIEW = "LiveChatWebView";
  static String DASHBOARD = "Dashboard";
  static String FORUM = "Forum";
  static String STATUS = "Status";
  static String COMMENTPAGE = "CommentPage";
  static String PICTUREPAGE = "PicturePage";
  static String ADMINPACKAGES = "AdminPackagesPost";
  static String ADMINPACKAGESGET = "AdminPackagesGET";
  static String TOTALUSER = "TotalUser";
  static String ADMINVIDEOPOST = "AdminVideoPost";
  static String PAYMENTVIEWPAGE = "PaymentViewPage";
  static String WEBVIEWPAYMENTDATAPAGE = "PaymentDataPage";
  static String USERHOMEPAGE = "UserHomePage";
  static String PREVIOUSACTIVITY = "PreviousActivity";

  static List<GetPage> AppRoutesList() {
    return [
      GetPage(name: INITIAL, page: () => SplashPage()),
      GetPage(name: LOGIN, page: () => LoginPage()),
      GetPage(name: SIGNUP, page: () => SignUpPage()),
      GetPage(name: HOMEPAGE, page: () => AdminHomePage()),
      GetPage(name: SUBSCRIPTION, page: () => SubscriptionPage()),
      GetPage(name: PACKAGES, page: () => Packages()),
      GetPage(name: DASHBOARD, page: () => Dashboard()),
      GetPage(name: FORUM, page: () => ForumPage()),
      GetPage(name: STATUS, page: () => StatusPage()),
      GetPage(name: COMMENTPAGE, page: () => CommentPage()),
      GetPage(name: PICTUREPAGE, page: () => PicturePage()),
      GetPage(name: ADMINPACKAGES, page: () => AdminPackages()),
      GetPage(name: ADMINPACKAGESGET, page: () => AdminPackagesGet()),
      GetPage(name: TOTALUSER, page: () => TotalUser()),
      GetPage(name: ADMINVIDEOPOST, page: () => AdminVideoPost()),
      GetPage(name: USERHOMEPAGE, page: () => UserHomePage()),
      GetPage(name: PREVIOUSACTIVITY, page: () => PreviousActivity()),
      GetPage(name: PAYMENTVIEWPAGE, page: () => PaymentWebView()),
      GetPage(name: LIVECHATWEBVIEW, page: () => LiveChatWebView()),
    ];
  }
}
