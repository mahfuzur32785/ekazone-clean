import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/constants.dart';
import '../../../utils/k_images.dart';
import '../main_controller.dart';

class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({
    Key? key,
    required this.mainController,
    required this.selectedIndex,
  }) : super(key: key);
  final MainController mainController;
  final int selectedIndex;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 9,
      color: const Color(0x00ffffff),
      shadowColor: blackColor,
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(0)),
        child: BottomNavigationBar(
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,

          selectedLabelStyle: const TextStyle(fontSize: 14, color: redColor),
          unselectedLabelStyle:
              const TextStyle(fontSize: 14, color: Color(0xff85959E)),
          items: <BottomNavigationBarItem>[

            const BottomNavigationBarItem(
              icon: Icon(Icons.home,
                  color: paragraphColor),
              activeIcon: Icon(Icons.home,color: redColor,),
              label: "Home",
            ),

            const BottomNavigationBarItem(
              tooltip: "Compare Ads",
              activeIcon: Icon(Icons.change_circle,color: redColor,),
              icon: Icon(Icons.change_circle_outlined, color: paragraphColor),
              label: "Compare Ads",
            ),

            const BottomNavigationBarItem(
              tooltip: "Profile",
              activeIcon:
              Icon(Icons.person_outline_outlined, color: redColor),
              icon:
              Icon(Icons.person_outline_outlined, color: paragraphColor),
              label: "Profile",
            ),
          ],
          // type: BottomNavigationBarType.fixed,
          currentIndex: selectedIndex,
          onTap: (int index) {
            print("$index");
            mainController.naveListener.sink.add(index);
          },
        ),
      ),
    );
  }
}
