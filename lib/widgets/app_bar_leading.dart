import 'dart:io';

import 'package:flutter/material.dart';

import '../utils/constants.dart';

class AppbarLeading extends StatelessWidget {
  const AppbarLeading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0),
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: borderColor),
          ),
          child: Icon(
            Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios_new,
            color: blackColor,
          ),
        ),
      ),
    );
  }
}
