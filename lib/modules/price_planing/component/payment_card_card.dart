import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/constants.dart';
class PaymentMethodCard extends StatelessWidget {
  const PaymentMethodCard({
    Key? key,
    this.title,
    this.icon,
    this.press,
  }) : super(key: key);

  final String? title;
  final String? icon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: InkWell(
        onTap: press,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          decoration: BoxDecoration(
              color: redColor.withOpacity(0.05),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: redColor.withOpacity(0.1),
                width: 1,
              )),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Image.asset(icon!,height: 35,)),
              Expanded(
                flex: 3,
                child: Text(
                  title!,
                  style:
                  const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
              ),
              const Icon(Icons.arrow_forward),
            ],
          ),
        ),
      ),
    );
  }
}