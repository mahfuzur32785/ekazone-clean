import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class BackAllLocationTile extends StatelessWidget {
  const BackAllLocationTile({Key? key, required this.title, required this.onPressed, required this.isShow}) : super(key: key);

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
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Visibility(
                    visible: isShow,
                    child: const Icon(Icons.arrow_back_outlined,color: Colors.black45,),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(title,style: const TextStyle(color: Colors.black54,fontSize: 15),),
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
