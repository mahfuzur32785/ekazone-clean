import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class StaticWidgets {
  Widget orSelectLocation(){
    return SliverToBoxAdapter(
      child: Container(
        width: double.infinity,
        color: ashColor,
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: const Center(
          child: Text("or select a location",style: TextStyle(color: Colors.black87,fontSize: 16,fontWeight: FontWeight.w500),),
        ),
      ),
    );
  }
}