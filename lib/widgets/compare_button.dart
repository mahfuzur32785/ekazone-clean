import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../core/router_name.dart';
import '../modules/profile/controller/wish_list/wish_list_cubit.dart';
import '../utils/constants.dart';
import '../utils/utils.dart';

class CompareButton extends StatefulWidget {
  CompareButton(
      {Key? key, required this.productId, this.from, this.index, this.adsUserId, this.logInUserId})
      : super(key: key);
  final int productId;
  String? from;
  int? index;
  int? adsUserId;
  int? logInUserId;

  @override
  State<CompareButton> createState() => _CompareButtonState();
}

class _CompareButtonState extends State<CompareButton> {
  final double height = 28;

  @override
  Widget build(BuildContext context) {

    final box = Hive.box('compareList');
    var isCompare = box.get(widget.index) != null;

    return Visibility(
      visible: true /*Utils.isShowFavorite(context)*/,
      child: InkWell(
          onTap: () async {

            print("${widget.productId} hjfajdksfhaisf");

            if(widget.logInUserId == widget.adsUserId){
              print("This is your ads");
              Utils.showSnackBar(context, "You can not add your ads to your compare list ");
            }
            else{
              if(box.length<3) {
                setState(() {
                  isCompare = true;
                });
                Utils.showSnackBar(context, "Item added to your compare list");
                box.put(widget.index, widget.productId);
              }
              else{
                Utils.errorSnackBar(context, "You can not add more than 3 ads");
              }
            }
            print('Compare list length ${box.length} box index ${box.keys.map((e) => e).toList()} box item ${box.values.map((e) => e).toList()}');
          },
          child: isCompare
              ? const Icon(
                  Icons.change_circle,
                  color: Colors.black,
                  size: 20,
                )
              : Icon(
                  Icons.change_circle_outlined,
                  color: Colors.grey.shade500,
                  size: 20,
                ),
      ),
    );
  }
}
