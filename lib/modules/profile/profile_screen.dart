import 'package:ekayzone/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ekayzone/widgets/please_signin_widget.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../core/router_name.dart';
import '../../utils/constants.dart';
import '../authentication/controllers/login/login_bloc.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final scrollController = ScrollController();

  void toTop(){
    scrollController.animateTo(0,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {

    String? selectedValue;

    final userData = context.read<LoginBloc>().userInfo;

    if (userData == null) {
      return const PleaseSignInWidget();
    }

    return CustomScrollView(
      controller: scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        const SliverAppBar(
          title: Text("Overview"),
          pinned: true,
          // actions: [
          //   BlocBuilder<LanguageCubit,LanguageState>(
          //     builder: (context,state) {
          //       if (state is LanguageStateLoaded) {
          //         return SizedBox(
          //           height: 50,
          //           child: PopupMenuButton(
          //             icon: Material(
          //               borderRadius: BorderRadius.circular(3),
          //               color: Colors.white,
          //               child: Padding(
          //                 padding: EdgeInsets.symmetric(horizontal: 24,vertical: 8),
          //                 // child: Text(AppLocalizations.of(context).languageCode.toUpperCase()),
          //                 child: Text("$selected"),
          //                 // child: Text(AppLocalizations.of(context).countryName),
          //               ),
          //             ),
          //             itemBuilder: (context) => <PopupMenuEntry>[
          //               ...List.generate(countryListData.length, (index) {
          //                 return PopupMenuItem(
          //                   onTap: () {
          //                     setState(() {
          //                       selected = countryListData[index];
          //                     });
          //                   },
          //                   // onTap: (){
          //                   //   BlocProvider.of<LocaleCubit>(context).toChange(state.languageList[index].code);
          //                   //   // if (state.languageList[index].code != 'bi') {
          //                   //   //   if (kDebugMode) {
          //                   //   //     print("${state.languageList[index].name}/${state.languageList[index].code}");
          //                   //   //   }
          //                   //   //   BlocProvider.of<LocaleCubit>(context).toChange(state.languageList[index].code);
          //                   //   // } else {
          //                   //   //   Utils.showSnackBar(context, "${state.languageList[index].name} is not supported");
          //                   //   // }
          //                   // },
          //                   child: Row(
          //                     children: [
          //                       // FaIcon(state.languageList[index].icon,),
          //                       // // FaIcon('flag-icon flag-icon-gb',color: Colors.red,),
          //                       // const SizedBox(width: 16,),
          //                       Text(countryListData[index]),
          //                     ],
          //                   ),
          //                 );
          //               }),
          //             ],
          //           ),
          //
          //         );
          //       }
          //       return const SizedBox();
          //     }
          //   ),
          // ],
        ),
        _buildProfileOptions(context),
        const SliverToBoxAdapter(child: SizedBox(height: 65)),
      ],
    );
  }

  SliverPadding _buildProfileOptions(BuildContext context) {
    final userData = context.read<LoginBloc>().userInfo;
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [
            // ExpansionTile(
            //   tilePadding: const EdgeInsets.symmetric(horizontal: 16),
            //   title: Text('${AppLocalizations.of(context).translate('app_menu')}'),
            //   leading: const Icon(Icons.menu,color: redColor,),
            //   children: <Widget>[
            //     // ListTile(
            //     //   minLeadingWidth: 0,
            //     //   onTap: () {
            //     //     // Navigator.pushNamed(context, RouteNames.sellerScreen);
            //     //   },
            //     //   contentPadding: EdgeInsets.zero,
            //     //   leading: const Icon(Icons.home,size: 27,color: redColor,),
            //     //   title: Text("${AppLocalizations.of(context).translate('home')}", style: const TextStyle(fontSize: 16)),
            //     // ),
            //     ListTile(
            //       minLeadingWidth: 0,
            //       onTap: () {
            //         Navigator.pushNamed(context, RouteNames.sellerScreen);
            //       },
            //       contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            //       leading: const Icon(Icons.sell,size: 27,color: redColor,),
            //       title: Text("${AppLocalizations.of(context).translate('sellers')}", style: const TextStyle(fontSize: 16)),
            //     ),
            //     ListTile(
            //       minLeadingWidth: 0,
            //       onTap: () {
            //         Navigator.pushNamed(context, RouteNames.pricePlaningScreen);
            //       },
            //       contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            //       leading: const CustomImage(path: Kimages.profileDollarIcon,height: 27,width: 27,color: redColor,),
            //       title: Text("${AppLocalizations.of(context).translate('pricing')}", style: const TextStyle(fontSize: 16)),
            //     ),
            //     ListTile(
            //       minLeadingWidth: 0,
            //       onTap: () {
            //         // Navigator.pushNamed(context, RouteNames.createEvent);
            //         Navigator.pushNamed(context, RouteNames.myEventsScreen);
            //       },
            //       contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            //       leading: const Icon(Icons.event,size: 27,color: redColor,),
            //       title: Text("${AppLocalizations.of(context).translate('my_events')}", style: const TextStyle(fontSize: 16)),
            //     ),
            //     ListTile(
            //       minLeadingWidth: 0,
            //       onTap: () {
            //         Navigator.pushNamed(context, RouteNames.myDirectoryScreen);
            //       },
            //       contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            //       leading: const Icon(Icons.shopping_bag_outlined,size: 27,color: redColor,),
            //       title: Text("${AppLocalizations.of(context).translate('business_directory')}", style: const TextStyle(fontSize: 16)),
            //     ),
            //     ListTile(
            //       minLeadingWidth: 0,
            //       onTap: () {
            //         Navigator.pushNamed(context, RouteNames.categorySelection);
            //       },
            //       contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            //       leading: const CustomImage(path: Kimages.profileCategoryIcon,color: redColor,),
            //       title: Text("${AppLocalizations.of(context).translate('all_categories')}", style: const TextStyle(fontSize: 16)),
            //     ),
            //     ListTile(
            //       onTap: () {
            //         Navigator.pushNamed(context, RouteNames.faqScreen);
            //       },
            //       minLeadingWidth: 0,
            //       contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            //       leading: const CustomImage(path: Kimages.profileFaqIcon,color: redColor,),
            //       title: Text("${AppLocalizations.of(context).translate('faq')}", style: const TextStyle(fontSize: 16)),
            //     ),
            //     ListTile(
            //       onTap: () {
            //         Navigator.pushNamed(context, RouteNames.aboutUsScreen);
            //       },
            //       minLeadingWidth: 0,
            //       contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            //       leading: const CustomImage(path: Kimages.profileAboutUsIcon,color: redColor,),
            //       title: Text("${AppLocalizations.of(context).translate('about_us')}", style: const TextStyle(fontSize: 16)),
            //     ),
            //     ListTile(
            //       onTap: () {
            //         Navigator.pushNamed(context, RouteNames.contactUsScreen);
            //       },
            //       minLeadingWidth: 0,
            //       contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            //       leading: const CustomImage(path: Kimages.profileContactIcon,color: redColor,),
            //       title: Text("${AppLocalizations.of(context).translate('contact')}", style: const TextStyle(fontSize: 16)),
            //     ),
            //     ListTile(
            //       onTap: () {
            //         Navigator.pushNamed(context, RouteNames.postingRulesScreen);
            //       },
            //       minLeadingWidth: 0,
            //       contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            //       leading:
            //       const CustomImage(path: Kimages.profileTermsConditionIcon,color: redColor,),
            //       title: Text("${AppLocalizations.of(context).translate('posting_rules')}", style: const TextStyle(fontSize: 16)),
            //     ),
            //     ListTile(
            //       onTap: () {
            //         Navigator.pushNamed(context, RouteNames.termsConditionScreen);
            //       },
            //       minLeadingWidth: 0,
            //       contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            //       leading: const Icon(Icons.library_books,color: redColor,),
            //       // leading: const CustomImage(path: Kimages.profileTermsConditionIcon,color: redColor,),
            //       title: Text("${AppLocalizations.of(context).translate('terms_conditions')}", style: const TextStyle(fontSize: 16)),
            //     ),
            //     ListTile(
            //       onTap: () {
            //         Navigator.pushNamed(context, RouteNames.privacyPolicyScreen);
            //       },
            //       minLeadingWidth: 0,
            //       contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            //       leading: const CustomImage(path: Kimages.profilePrivacyIcon,color: redColor,),
            //       title: Text("${AppLocalizations.of(context).translate('privacy_policy')}", style: const TextStyle(fontSize: 16)),
            //     ),
            //   ],
            // ),

            ListTile(
              minLeadingWidth: 0,
              onTap: () {
                Navigator.pushNamed(context, RouteNames.dashboardScreen);
              },
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              leading: const Icon(Icons.home_outlined,size: 27,color: Colors.black54,),
              title: const Text("Dashboard", style: TextStyle(fontSize: 16)),
            ),
            ListTile(
              minLeadingWidth: 0,
              onTap: () {
                Navigator.pushNamed(context, RouteNames.publicShopScreen,arguments: userData?.user.username);
              },
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              leading: const Icon(Icons.person_outline,size: 27,color: Colors.black54,),
              title: const Text("My Shop", style: TextStyle(fontSize: 16)),
            ),
            ListTile(
              minLeadingWidth: 0,
              onTap: () {
                // Navigator.pushNamed(context, RouteNames.postAd);
                Navigator.pushNamed(context, RouteNames.newPostAd);
              },
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              leading: const Icon(Icons.add,size: 27,color: Colors.black54,),
              title: const Text("Ad Post", style: TextStyle(fontSize: 16)),
            ),
            ListTile(
              minLeadingWidth: 0,
              onTap: () {
                Navigator.pushNamed(context, RouteNames.customerAds);
              },
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              leading: const Icon(Icons.format_list_bulleted,size: 27,color: Colors.black54,),
              title: const Text("My Ads", style: TextStyle(fontSize: 16)),
            ),
            ListTile(
              minLeadingWidth: 0,
              onTap: () {
                Navigator.pushNamed(context, RouteNames.compareScreen);
              },
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              leading: const Icon(Icons.change_circle_outlined,size: 27,color: Colors.black54,),
              title: const Text("Compare Ads", style: TextStyle(fontSize: 16)),
            ),
            ListTile(
              minLeadingWidth: 0,
              onTap: () {
                Navigator.pushNamed(context, RouteNames.wishListScreen);
              },
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              leading: const Icon(Icons.favorite_outline,size: 27,color: Colors.black54,),
              title: const Text("Favorite ads", style: TextStyle(fontSize: 16)),
            ),
            ListTile(
              minLeadingWidth: 0,
              onTap: () {
                Navigator.pushNamed(context, RouteNames.chatScreen);
              },
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              leading: const Icon(Icons.question_answer_outlined,size: 27,color: Colors.black54,),
              title: const Text("Chat", style: TextStyle(fontSize: 16)),
            ),
            ListTile(
              minLeadingWidth: 0,
              onTap: () {
                Navigator.pushNamed(context, RouteNames.planAndBillings);
              },
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              leading: const Icon(Icons.article_outlined,color: Colors.black54,),
              // leading: const CustomImage(path: Kimages.profileDollarIcon,height: 27,width: 27,color: redColor,),
              title: const Text("Transactions", style: TextStyle(fontSize: 16)),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, RouteNames.profileEditScreen);
              },
              minLeadingWidth: 0,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              leading: const Icon(Icons.settings_outlined,size: 27,color: Colors.black54,),
              title: const Text("Setting", style: TextStyle(fontSize: 16)),
            ),
            BlocBuilder<LoginBloc, LoginModelState>(builder: (context, state) {
              if (state.state is LoginStateLogOutLoading) {
                const CircularProgressIndicator();
              }
              return ListTile(
                minLeadingWidth: 0,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                leading: const Icon(Icons.exit_to_app_outlined,size: 27,color: Colors.black54,),
                title: const Text("Logout", style: TextStyle(fontSize: 16)),
                onTap: () {
                  Utils.loadingDialog(context);
                  context.read<LoginBloc>().add(const LoginEventLogout());
                  Hive.box('compareList').clear();
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
