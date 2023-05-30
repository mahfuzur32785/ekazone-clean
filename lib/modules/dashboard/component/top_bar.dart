import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ekayzone/core/router_name.dart';
import 'package:ekayzone/modules/authentication/controllers/login/login_bloc.dart';

import '../../../utils/constants.dart';
import '../../../utils/k_images.dart';
import '../model/overview_model.dart';

class DashboardTopBar extends StatelessWidget {
  const DashboardTopBar({Key? key, required this.overViewModel}) : super(key: key);
  final DOverViewModel overViewModel;

  @override
  Widget build(BuildContext context) {
    final loginBloc = context.read<LoginBloc>();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 26,
          backgroundColor: Colors.white,
          backgroundImage: NetworkImage("${loginBloc.userInfo!.user.imageUrl}"),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             Text(loginBloc.userInfo!.user.name != '' ? "${loginBloc.userInfo?.user.name}" : "No name",style: const TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w500),),
              Text("${overViewModel.adsCount.activeAdsCount} Active posted ads",style: const TextStyle(color: Colors.black45,fontSize: 13,fontWeight: FontWeight.w400),),
            ],
          ),
        ),
        Material(
          color: Colors.white.withAlpha(910),
          elevation: 3,
          shadowColor: const Color(0xFFFFFFFF),
          borderOnForeground: true,
          shape: const CircleBorder(),
          child: InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: (){
              Navigator.pushNamed(context, RouteNames.profileEditScreen);
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              child: const Icon(Icons.edit,color: redColor,size: 20,),
            ),
          ),
        ),
      ],
    );
  }
}
