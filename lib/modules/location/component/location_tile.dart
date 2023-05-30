import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class LocationTile extends StatelessWidget {
  const LocationTile({Key? key, required this.title, required this.onPressed, required this.isShow}) : super(key: key);

  final String title;
  final Function onPressed;
  final bool isShow;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: (){
          onPressed();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title,style: const TextStyle(color: Colors.black87,fontSize: 15),),
                  Visibility(
                    visible: isShow,
                    child: const Material(
                      shape: CircleBorder(),
                      color: ashColor,
                      child: Padding(
                        padding: EdgeInsets.all(3),
                        child: Icon(Icons.keyboard_arrow_right_outlined),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(
              height: 1,
              thickness: 0.5,
            )
          ],
        ),
      ),
    );
  }
}
