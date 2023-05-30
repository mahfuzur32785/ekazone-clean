import 'package:ekayzone/modules/ads/ads_screen.dart';
import 'package:ekayzone/modules/authentication/component/reset_new_pass_screen.dart';
import 'package:ekayzone/modules/payment_gateway/payfast/payfast_payment.dart';
import 'package:ekayzone/modules/profile/compare_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:ekayzone/modules/ad_details/ad_details_screen.dart';
import 'package:ekayzone/modules/ad_details/model/ad_details_model.dart';
import 'package:ekayzone/modules/blog/blog_screen.dart';
import 'package:ekayzone/modules/category/category_screen.dart';
import 'package:ekayzone/modules/chat/chat_details_screen.dart';
import 'package:ekayzone/modules/chat/chat_screen.dart';
import 'package:ekayzone/modules/dashboard/dashboard_screen.dart';
import 'package:ekayzone/modules/location/location_screen.dart';
import 'package:ekayzone/modules/main/main_screen.dart';
import 'package:ekayzone/modules/my_plans/my_plans_screen.dart';
import 'package:ekayzone/modules/payment_gateway/paypal/paypal_payment.dart';
import 'package:ekayzone/modules/payment_gateway/stripe_screen.dart';
import 'package:ekayzone/modules/post_ad/post_ad_screen.dart';
import 'package:ekayzone/modules/price_planing/plan_details_screen.dart';
import 'package:ekayzone/modules/profile/change_password_screen.dart';
import 'package:ekayzone/modules/profile/edti_profile_screen.dart';
import 'package:ekayzone/modules/profile/public_profile.dart';
import 'package:ekayzone/modules/profile/wish_list_screen.dart';
import 'package:ekayzone/modules/seller/seller_list_screen.dart';

import '../modules/ads/customer_ads_screen.dart';
import '../modules/ads/new_ad_edit/new_ad_edit_screen.dart';
import '../modules/animated_splash/animated_splash_screen.dart';
import '../modules/authentication/authentication_screen.dart';
import '../modules/authentication/component/forgot_screen.dart';
import '../modules/authentication/product_details/product_details_screen.dart';
import '../modules/new_post_ad/new_post_ad_screen.dart';
import '../modules/onboarding/onboarding_screen.dart';
import '../modules/price_planing/price_planing_screen.dart';
import '../modules/public_shop/public_shop_screen.dart';

class RouteNames {
  static const String onBoardingScreen = '/onBoardingScreen';
  static const String animatedSplashScreen = '/';
  static const String mainPage = '/mainPage';

  static const String authenticationScreen = '/authenticationScreen';
  static const String accDeletionScreen = '/accDeletionScreen';
  static const String forgotScreen = '/forgotScreen';
  static const String verificationCodeScreen = '/verificationCodeScreen';
  static const String setPasswordScreen = '/setPasswordScreen';

  static const String allCategoryListScreen = '/allCategoryListScreen';
  static const String locationSelection = '/locationSelection';
  static const String categorySelection = '/categorySelection';

  static const String postAd = '/postAd';
  static const String newPostAd = '/newPostAd';

  static const String adEditScreen = '/adEditScreen';
  static const String adDetails = '/adDetails';

  static const String customerAds = '/customerAds';
  static const String sellerScreen = '/sellerScreen';
  static const String adsScreen = '/adsScreen';

  static const String directoryDetails = 'directoryDetails';
  static const String myDirectoryScreen = 'myDirectoryScreen';
  static const String createDirectoryScreen = 'createDirectoryScreen';

  static const String notificationScreen = '/notificationScreen';
  static const String messageScreen = '/messageScreen';
  static const String singleCategoryProductScreen =
      '/singleCategoryProductScreen';

  static const String blog = '/blog';
  static const String termsConditionScreen = '/termsConditionScreen';
  static const String postingRulesScreen = '/postingRulesScreen';
  static const String privacyPolicyScreen = '/privacyPolicyScreen';
  static const String faqScreen = '/faqScreen';
  static const String aboutUsScreen = '/aboutUsScreen';
  static const String contactUsScreen = '/contactUsScreen';
  static const String wishListScreen = '/wishListScreen';
  static const String compareScreen = '/compareScreen';

  //........... E V E N T S............
  static const String eventDetailsScreen = "/eventDetailsScreen";
  static const String createEvent = "/createEvent";
  static const String myEventsScreen = "/myEventsScreen";

  static const String dashboardScreen = '/dashboardScreen';
  static const String pricePlaningScreen = '/pricePlaningScreen';
  static const String publicProfile = '/publicProfile';
  static const String publicShopScreen = '/myShopScreen';

  static const String profileEditScreen = '/profileEditScreen';
  static const String chatScreen = '/chatScreen';
  static const String chatDetails = '/chatDetails';
  static const String addAddressScreen = '/addAddressScreen';
  static const String cartScreen = '/cartScreen';
  static const String checkoutScreen = '/checkoutScreen';
  static const String productDetailsScreen = '/productDetailsScreen';
  static const String addressScreen = '/addressScreen';
  static const String productSearchScreen = '/productSearchScreen';
  static const String changePasswordScreen = '/changePasswordScreen';
  static const String profileContactIcon =
      "assets/icons/profile_contact_icon.svg";

  static const String stripeScreen = '/stripeScreen';
  static const String paypalScreen = '/paypalScreen';
  static const String payfastScreen = '/payfastScreen';
  static const String planDetailsScreen = '/planDetailsScreen';
  static const String planAndBillings = '/planAndBillings';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.onBoardingScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const OnBoardingScreen());
      // case RouteNames.changePasswordScreen:
      //   return MaterialPageRoute(
      //       settings: settings, builder: (_) => const ChangePasswordScreen());


      case RouteNames.mainPage:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const MainScreen());
      case RouteNames.animatedSplashScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const AnimatedSplashScreen());
      case RouteNames.changePasswordScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ChangePasswordScreen());
      case RouteNames.authenticationScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const AuthenticationScreen());
      case RouteNames.forgotScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ForgotScreen());

      case RouteNames.setPasswordScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ResetNewPasswordScreen());

      case RouteNames.locationSelection:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const LocationScreen());
      case RouteNames.categorySelection:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const CategoryScreen());

      case RouteNames.postAd:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const PostAdScreen());

      case RouteNames.newPostAd:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const NewPostAdScreen());

      case RouteNames.adEditScreen:
        final AdDetails adModel = settings.arguments as AdDetails;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => NewAdEditScreen(
              adModel: adModel,
            ));

      case RouteNames.adDetails:
        final slug = settings.arguments as String;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => AdDetailsScreen(
                  slug: slug,
                ));
      case RouteNames.customerAds:
        // final slug = settings.arguments as String;
        return MaterialPageRoute(
            settings: settings, builder: (_) => const CustomerAdsScreen());
      case RouteNames.sellerScreen:
        // final slug = settings.arguments as String;
        return MaterialPageRoute(
            settings: settings, builder: (_) => const SellerListScreen());

      case RouteNames.publicShopScreen:
        final username = settings.arguments as String;
        return MaterialPageRoute(
            settings: settings, builder: (_) => MyShopScreen(
          username: username,
        ));

      case RouteNames.adsScreen:
        final slug = settings.arguments as List;
        return MaterialPageRoute(
            settings: settings, builder: (_) => AdsScreen(
          categoryValue: slug[0],
          searchValue: slug[1],
          locationValue: slug[2],
          distanceValue: slug[3],
        ));

      case RouteNames.blog:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const BlogScreen());
      case RouteNames.dashboardScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const DashboardScreen());
      case RouteNames.pricePlaningScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const PricePlaningScreen());
      case RouteNames.publicProfile:
        final username = settings.arguments as String;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => PublicProfile(
                  username: username,
                ));
      case RouteNames.profileEditScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const EditProfileScreen());

      case RouteNames.wishListScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const WishListAdScreen());
        case RouteNames.compareScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const CompareListAdScreen());
      case RouteNames.chatScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ChatScreen());
      case RouteNames.chatDetails:
        final username = settings.arguments as String;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => ChatDetailsScreen(
                  username: username,
                ));
      case RouteNames.productDetailsScreen:
        final slug = settings.arguments as String;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => ProductDetailsScreen(slug: slug));
      case RouteNames.stripeScreen:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => const StripeScreen(
                  shippingMethodId: '',
                ));
      case RouteNames.paypalScreen:
        final event = settings.arguments as PaypalPaymentArguments;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => PaypalPayment(
                  adId: event.adId, id: event.id,title: event.title,price: event.price,
                ));

        case RouteNames.payfastScreen:
        final event = settings.arguments as PayfastPaymentArguments;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => PayfastPayment(
                  adDetails: event.adDetails, id: event.id,title: event.title,price: event.price,
                ));


      case RouteNames.planDetailsScreen:
        final event = settings.arguments as PlanDetailsScreenArguments;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => PlanDetailsScreen(
                   adDetails: event.adDetails,promotionId: event.id,title: event.title, price: event.price,
                ));
      case RouteNames.planAndBillings:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const MyPlansScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
