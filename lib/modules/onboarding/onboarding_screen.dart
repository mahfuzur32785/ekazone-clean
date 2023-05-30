import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/router_name.dart';
import '../../utils/constants.dart';
import '../../widgets/custom_image.dart';
import '../animated_splash/controller/app_setting_cubit.dart';
import 'model/onbording_data.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override OnBoardingScreenState createState() => OnBoardingScreenState();
}

class OnBoardingScreenState extends State<OnBoardingScreen> {
  final int _numPages = 3;
  final _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: kDuration,
      margin: const EdgeInsets.only(right: 5),
      height: 10.0,
      width: 10.0,
      decoration: BoxDecoration(
        color: isActive ? redColor : borderColor,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  Widget getContent() {
    final item = onBoardingList[_currentPage];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      key: ValueKey('$_currentPage'),
      children: [
        Text(
          item.subTitle,
          style: const TextStyle(fontSize: 28),
        ),
        Text(
          item.title,
          style: GoogleFonts.poppins(fontSize: 30, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 18),
        Text(item.paragraph,
            style: TextStyle(fontSize: 16, color: blackColor.withOpacity(.5))),
      ],
    );
  }

  late Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildImagesSlider(),
              _buildBottomContent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          AnimatedSwitcher(
            duration: kDuration,
            transitionBuilder: (Widget child, Animation<double> anim) {
              return FadeTransition(opacity: anim, child: child);
            },
            child: getContent(),
          ),
          const SizedBox(height: 25),
          _buildBottomButtonIndicator(),
        ],
      ),
    );
  }

  Widget _buildBottomButtonIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _buildPageIndicator(),
        ),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white, minimumSize: const Size(80, 80),
            backgroundColor: redColor,
            shape: const CircleBorder(),
          ),
          onPressed: () {
            if (_currentPage == 2) {
              context.read<AppSettingCubit>().cacheOnBoarding();
              Navigator.pushReplacementNamed(
                  context, RouteNames.mainPage);
              return;
            }
            _pageController.nextPage(
                duration: kDuration, curve: Curves.easeInOut);
          },
          child: const Center(child: Text("Next")),
        ),
      ],
    );
  }

  Widget _buildImagesSlider() {
    return SizedBox(
      height: size.height / 2.57,
      child: PageView(
        physics: const ClampingScrollPhysics(),
        controller: _pageController,
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
        },
        children: onBoardingList.map((e) => CustomImage(path: e.image)).toList(),
      ),
    );
  }
}
