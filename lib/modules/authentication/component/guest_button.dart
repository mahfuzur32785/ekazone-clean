import 'package:flutter/material.dart';

import '../../../core/router_name.dart';
import '../../../utils/constants.dart';

class GuestButton extends StatelessWidget {
  const GuestButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        Navigator.pushNamedAndRemoveUntil(
            context, RouteNames.mainPage, (route) => false);
      },
      child: const Text(
        'Continue as Guest',
        style: TextStyle(
            fontSize: 14,
            height: 1,
            color: blackColor,
            fontWeight: FontWeight.w600),
      ),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        minimumSize: const Size(200, 44),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        side: const BorderSide(color: paragraphColor, width: 1),
      ),
    );
  }
}
