import 'package:flutter/material.dart';
import '../utils/constants.dart';
import 'app_bar_leading.dart';

class RoundedAppBar extends AppBar {
  final String? titleText;

  final Color bgColor;
  final Color textColor;
  final void Function()? onTap;
  final List<Widget> action;

  final ShapeBorder shapeBorder;
  RoundedAppBar({
    this.titleText,
    this.textColor = Colors.white,
    this.bgColor = redColor,
    this.shapeBorder = const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(0)),
    ),
    this.onTap,
    this.action = const [],
    Key? key,
  }) : super(
          key: key,
          titleSpacing: 0,
          backgroundColor: bgColor,
          shape: shapeBorder,
          leading: const AppbarLeading(),
          iconTheme: const IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
              color: textColor, fontSize: 18, fontWeight: FontWeight.w600),
          title: titleText != null ? Text(titleText) : null,
          elevation: 0.0,
          actions: action,
          automaticallyImplyLeading: false,
        );
}
