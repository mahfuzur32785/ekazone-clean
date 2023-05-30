class RemoteUrls {

  // static const String rootUrl = "http://192.168.203.60:8000/";
  static const String rootUrl = "https://www.ekayzone.com/";
  static const String baseUrl = "${rootUrl}api/";

  static String homeUrl(countryCode) => "${baseUrl}home?country_code=$countryCode";
  static const String userRegister = '${baseUrl}auth/register';
  static const String socialLogin = '${baseUrl}auth/social-login';
  static const String userLogin = '${baseUrl}auth/login';

  static const String postAdCreate = '${baseUrl}ads';
  static String adUpdate(String id) => '${baseUrl}ads/$id/update';
  static const String myPlanBilling = '${baseUrl}customer/recent-invoices';
  static const String paymentGateways = '${baseUrl}pamentgetways';
  static const String paymentConfirmation = '${baseUrl}payment-success';
  static const String editProfile = '${baseUrl}auth/profile';
  static const String changePassword = '${baseUrl}auth/password';
  static String deleteAccount(delete) => '${baseUrl}customer/account-delete?confirm=${delete}';



  static const String sendForgetPassword = '${baseUrl}auth/password/email';
  static String storeResetPassword = '${baseUrl}auth/password/reset';

  static String userProfile = '${baseUrl}auth/me';
  static String publicProfile(String username, String sortBy) =>
      '${baseUrl}seller/$username?sort_by=$sortBy';
  static String dashboardOverview = '${baseUrl}customer/dashboard-overview';
  static String passwordChange = '${baseUrl}auth/password';
  static String getChatUsers(String username) =>
      '${baseUrl}message/$username';
  static String postSellerReview(String seller) =>
      '${baseUrl}seller/review/$seller';
  static const String websiteSetup = '${baseUrl}settings';
  static const String getCountry = '${baseUrl}countries';
  static const String postReport = '${baseUrl}report/ads';
  static String productDetail(String slug, String countryCode) =>
      '${baseUrl}ads/$slug?country_code=$countryCode';
  static String deleteMyAd(int id) =>
      '${baseUrl}customer/ads/$id/delete';
  static String wishList = '${baseUrl}customer/favourite-list';
  static String compareList = '${baseUrl}ads/compare';
  static String addWish(int id,) =>
      '${baseUrl}ads/$id/favourite';
  static const String searchAds = '${baseUrl}ads?';
  static const String customerAds = '${baseUrl}customer/ads';

  static imageUrl(String imageUrl) => rootUrl + imageUrl;

  static const String donateUrl = "https://www.paypal.com/donate?token=M9OD2mJFkklUjO1gQVpEIEPLZG5oNuAhnqyTUSl3v3JbVMv0Y-GU0mOLdf-VDyPETrcwHxI01PFqZkm_";
  static const String alikaTrainingUrl = "https://www.alikatraining.co.za/";
  static const String alikaGuesthouseUrl = "https://www.alikaguesthouse.co.za";

}
