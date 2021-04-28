String baseUrl = "https://work.mshakhawat.com/api";

class AppUrl {
  static String signUpUrl = "$baseUrl/auth/register";
  static String loginUrl = "$baseUrl/auth/login";
  static String logoutUrl = "$baseUrl/auth/logout";
  static String userPackagesUrl = "$baseUrl/packages";
  static String userSubscriptionUrl = "$baseUrl/auth/charge";
  static String adminLoginUrl = "$baseUrl/admin/login";
  static String adminLogOutUrl = "$baseUrl/admin/logout";
  static String adminPackagesUrl = "$baseUrl/admin/package";
  static String adminDashboardUrl = "$baseUrl/admin/dashboard";
  static String adminTotalUserUrl = "$baseUrl/admin/user";
  static String adminPackagesStatusUrl = "$baseUrl/admin/change/package/status";
  static String adminRefreshTokenUrl = "$baseUrl/admin/refresh";
  static String adminVideoUrl = "$baseUrl/admin/video";
  static String forumStatusUrl = "$baseUrl/auth/add/post";
  static String forumUrl = "$baseUrl/auth/forum";
  static String commentUrl = "$baseUrl/auth/reply";
  static String replyUrl = "$baseUrl/auth/add/reply";
}
