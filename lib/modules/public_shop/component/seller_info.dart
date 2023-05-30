import 'package:ekayzone/core/router_name.dart';
import 'package:ekayzone/modules/authentication/controllers/login/login_bloc.dart';
import 'package:ekayzone/modules/profile/model/public_profile_model.dart';
import 'package:ekayzone/utils/utils.dart';
import 'package:ekayzone/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SellerInfo extends StatefulWidget {
  SellerInfo({Key? key,this.publicProfileModel}) : super(key: key);

  PublicProfileModel? publicProfileModel;

  @override
  State<SellerInfo> createState() => _SellerInfoState();
}

class _SellerInfoState extends State<SellerInfo> {

  @override
  Widget build(BuildContext context) {

    final currentUser = context.read<LoginBloc>();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade300,
              spreadRadius: 1,
              blurRadius: 1)
        ],
      ),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey.shade300,
              backgroundImage: NetworkImage("${widget.publicProfileModel!.user.imageUrl}"),
            ),
            // CustomImage(path: '',width: 80,height: 50,color: Colors.grey.shade300,),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.publicProfileModel!.user.username,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    RatingBar.builder(
                      initialRating: double.parse(widget.publicProfileModel!.ratingDetails.average),
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      itemSize: 20,
                      itemPadding: const EdgeInsets.only(right: 2),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star_border,
                        color: Color(0xffF0A732),
                        // size: 5,
                      ),
                      onRatingUpdate: (rating) {},
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "(${widget.publicProfileModel!.ratingDetails.average})",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold),
                    ),
                    const Text("Reviews"),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 35,
                  width: 180,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if(currentUser.userInfo!.user.id == widget.publicProfileModel!.user.id){
                        Utils.showSnackBar(context, "You can not message with yourself");
                        return;
                      }else {
                        Navigator.pushNamed(
                            context, RouteNames.chatDetails,
                            arguments: widget.publicProfileModel!.user
                                .username);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF212d6e),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(2))),
                    icon: const Icon(Icons.question_answer_outlined,
                        size: 18),
                    label: const Text(
                      "Chat With Seller",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ]),
    );
  }
}
