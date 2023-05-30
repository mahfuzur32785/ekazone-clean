import 'dart:developer';
import 'package:ekayzone/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../core/router_name.dart';
import '../../utils/constants.dart';
import '../../utils/k_images.dart';
import '../../widgets/custom_image.dart';
import '../authentication/controllers/login/login_bloc.dart';
import 'controller/app_setting_cubit.dart';
import 'widgets/setting_error_widget.dart';

class AnimatedSplashScreen extends StatefulWidget {
  const AnimatedSplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<AnimatedSplashScreen>
    with SingleTickerProviderStateMixin {
  final _className = '_SplashScreenState';
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation.addListener(() {
      if (mounted) setState(() {});
    });
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final appSettingBloc = context.read<AppSettingCubit>();
    final loginBloc = context.read<LoginBloc>();
    return Scaffold(
      body: BlocConsumer<AppSettingCubit, AppSettingState>(
        listener: (context, state) async {
          if (state is AppSettingStateLoaded) {
            bool serviceEnabled;
            LocationPermission permission;

            serviceEnabled = await Geolocator.isLocationServiceEnabled();
            if (!serviceEnabled) {
              Utils.toastMsg('Location services are disabled.');
            }

            permission = await Geolocator.checkPermission();
            if (permission == LocationPermission.denied) {
              permission = await Geolocator.requestPermission();
              if (permission == LocationPermission.denied) {
                Utils.toastMsg('Location permission is required');
                if (loginBloc.isLoggedIn) {
                  Navigator.pushReplacementNamed(context, RouteNames.mainPage);
                } else if (appSettingBloc.isOnBoardingShown) {
                  // Navigator.pushReplacementNamed(context, RouteNames.authenticationScreen);
                  Navigator.pushReplacementNamed(context, RouteNames.mainPage);
                } else {
                  Navigator.pushReplacementNamed(context, RouteNames.mainPage);
                  // Navigator.pushReplacementNamed(context, RouteNames.onBoardingScreen);
                }
              }
            }
            if (permission == LocationPermission.deniedForever) {
              await openAppSettings();
              Utils.toastMsg('Location permission is required');
              if (loginBloc.isLoggedIn) {
                Navigator.pushReplacementNamed(context, RouteNames.mainPage);
              } else if (appSettingBloc.isOnBoardingShown) {
                // Navigator.pushReplacementNamed(context, RouteNames.authenticationScreen);
                Navigator.pushReplacementNamed(context, RouteNames.mainPage);
              } else {
                Navigator.pushReplacementNamed(context, RouteNames.mainPage);
                // Navigator.pushReplacementNamed(context, RouteNames.onBoardingScreen);
              }
            }
            else{
              var location = await Geolocator.getCurrentPosition();
              List<Placemark> placemarks =
              await placemarkFromCoordinates(location.latitude, location.longitude);
              appSettingBloc.location = placemarks[0].isoCountryCode!;
              print("Current Location ${appSettingBloc.location}");

              if (loginBloc.isLoggedIn) {
                Navigator.pushReplacementNamed(context, RouteNames.mainPage);
              } else if (appSettingBloc.isOnBoardingShown) {
                // Navigator.pushReplacementNamed(context, RouteNames.authenticationScreen);
                Navigator.pushReplacementNamed(context, RouteNames.mainPage);
              } else {
                Navigator.pushReplacementNamed(context, RouteNames.mainPage);
                // Navigator.pushReplacementNamed(context, RouteNames.onBoardingScreen);
              }
            }
          }
        },
        builder: (context, state) {
          if (state is AppSettingStateError) {
            return SettingErrorWidget(message: state.meg);
          }
          return AnimationWidget(animation: animation);
        },
      ),
    );
  }
}

class AnimationWidget extends StatelessWidget {
  const AnimationWidget({
    Key? key,
    required this.animation,
  }) : super(key: key);

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [whiteColor, whiteColor],
            ),
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          // child: const CustomImage(path: Kimages.backgroundShape),
          child: const SizedBox(),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomImage(
              path: Kimages.logoColor,
              width: animation.value * 250,
              height: animation.value * 250,
            ),
            const SizedBox(height: 50),
            const Center(child: CircularProgressIndicator(color: Color(0xFF3F51B5),))
          ],
        ),
      ],
    );
  }
}
