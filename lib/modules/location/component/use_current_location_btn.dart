import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class UseCurrentLocationBtn extends StatelessWidget {
  const UseCurrentLocationBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: (){},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            child: Row(
              children: const [
                Icon(Icons.location_on,color: Colors.green,),
                SizedBox(
                  width: 8,
                ),
                Text("Use Current Location",style: TextStyle(color: redColor,fontSize: 15),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
