import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/router_name.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';
import 'component/sign_in_form.dart';
import 'component/sign_up_form.dart';
import 'controllers/login/login_bloc.dart';
import 'controllers/sign_up/sign_up_bloc.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LoginBloc, LoginModelState>(
          listenWhen: (previous, current) => previous.state != current.state,
          listener: (context, state) {
            if (state.state is LoginStateError) {
              final status = state.state as LoginStateError;

              if (status.statusCode == 402) {
                Utils.showSnackBarWithAction(
                  context,
                  status.errorMsg,
                      () {
                    context
                        .read<LoginBloc>()
                        .add(const SentAccountActivateCodeSubmit());
                    Navigator.pushNamed(
                        context, RouteNames.verificationCodeScreen);
                  },
                );
              } else {
                print("xxxxxxxxxxxxxxxxxxxxxxxx");
                Utils.errorSnackBar(context, status.errorMsg);
              }
            } else if (state.state is LoginStateLoaded) {
              Navigator.pushReplacementNamed(context, RouteNames.mainPage);
            } else if (state.state is SendAccountCodeSuccess) {
              final messageState = state.state as SendAccountCodeSuccess;
              Utils.showSnackBar(context, messageState.msg);
            } else if (state.state is AccountActivateSuccess) {
              final messageState = state.state as AccountActivateSuccess;
              Utils.showSnackBar(context, messageState.msg);
              Navigator.pop(context);
            }
          },
        ),
        BlocListener<SignUpBloc, SignUpModelState>(
          listenWhen: (previous, current) {
            return previous.state != current.state;
          },
          listener: (context, state) {
            if (state.state is SignUpStateLoadedError) {
              final status = state.state as SignUpStateLoadedError;
              Utils.errorSnackBar(context, status.errorMsg);
            } else if (state.state is SignUpStateFormError) {
              final status = state.state as SignUpStateFormError;
              Utils.showSnackBar(context, status.errorMsg);
            } else if (state.state is SignUpStateLoaded) {
              final loadedData = state.state as SignUpStateLoaded;
              // Navigator.pushNamed(context, RouteNames.verificationCodeScreen);
              Utils.showSnackBar(context, "${loadedData.msg}. Please login now");
              _pageController.animateToPage(0,
                  duration: const Duration(microseconds: 1500), curve: Curves.bounceInOut);
            }
          },
        ),
      ],
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        // body: SafeArea(
        //   child: Container(
        //     height: MediaQuery.of(context).size.height,
        //     decoration: const BoxDecoration(
        //       gradient: LinearGradient(
        //         begin: Alignment.topCenter,
        //         end: Alignment.bottomRight,
        //         colors: [Colors.white, Color(0xffFFEFE7)],
        //       ),
        //     ),
        //     child: Center(
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.center,
        //         mainAxisSize: MainAxisSize.max,
        //         children: [
        //           const SizedBox(height: 20),
        //           CustomImage(
        //             // path: RemoteUrls.imageUrl(appSetting.settingModel!.logo),
        //             path: Kimages.logoColor,
        //             width: 280,
        //             height: 110,
        //           ),
        //           const SizedBox(height: 0),
        //           _buildHeader(),
        //           const SizedBox(height: 15),
        //           // _buildTabText(),
        //           SizedBox(
        //             height: MediaQuery.of(context).size.height * 1,
        //             child: PageView(
        //               physics: const ClampingScrollPhysics(),
        //               controller: _pageController,
        //               onPageChanged: (int page) {
        //                 setState(() {
        //                   _currentPage = page;
        //                 });
        //               },
        //               children: const [SigninForm(), SignUpForm()],
        //             ),
        //           )
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          // onPageChanged: (int page) {
          //   setState(() {
          //     _currentPage = page;
          //   });
          // },
          children: [SignInForm(pageController: _pageController), SignUpForm(pageController: _pageController)],
        ),
        // bottomNavigationBar: Container(
        //     height: 60,
        //     decoration: BoxDecoration(
        //         color: Colors.white,
        //         boxShadow: [
        //           BoxShadow(
        //               blurRadius: 50,
        //               offset: const Offset(0,10),
        //               color: Colors.grey.withOpacity(0.5)
        //           )
        //         ]
        //     ),
        //     padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 8),
        //     child: _buildTabText(),
        // ),
      ),
    );
  }

  // Widget _buildTabText() {
  //   const tabUnSelectedTextColor = Color(0xff797979);
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 20),
  //     child: Row(
  //       mainAxisSize: MainAxisSize.max,
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Expanded(
  //           child: ElevatedButton(
  //             style: ElevatedButton.styleFrom(backgroundColor: Colors.white,elevation: 0),
  //             onPressed: (){
  //               _pageController.animateToPage(0,
  //                   duration: kDuration, curve: Curves.bounceInOut);
  //             },
  //             child: Text("${AppLocalizations.of(context).translate('sign_in')}",style: TextStyle(
  //                 fontSize: 18,
  //                 fontWeight: FontWeight.w600,
  //                 color:
  //                 _currentPage == 0 ? blackColor : tabUnSelectedTextColor),),
  //           ),
  //         ),
  //         Container(
  //           color: borderColor,
  //           width: 1,
  //           height: 20,
  //           margin: const EdgeInsets.symmetric(horizontal: 16),
  //         ),
  //         Expanded(
  //           child: ElevatedButton(
  //             style: ElevatedButton.styleFrom(backgroundColor: Colors.white,elevation: 0),
  //             onPressed: (){
  //               _pageController.animateToPage(1,
  //                   duration: kDuration, curve: Curves.bounceInOut);
  //             },
  //             child: Text("${AppLocalizations.of(context).translate('sign_up')}",
  //               style: TextStyle(
  //                   fontSize: 18,
  //                   fontWeight: FontWeight.w600,
  //                   color:
  //                   _currentPage == 1 ? blackColor : tabUnSelectedTextColor),),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
