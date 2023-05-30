import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/router_name.dart';
import '../modules/profile/controller/wish_list/wish_list_cubit.dart';
import '../utils/constants.dart';
import '../utils/utils.dart';

class FavoriteButton extends StatefulWidget {
  FavoriteButton({Key? key, required this.productId, this.from, required this.isFav, this.adsUserId, this.logInUserId})
      : super(key: key);
  final int productId;
  bool isFav;
  String? from;
  int? adsUserId;
  int? logInUserId;

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  final double height = 28;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: Utils.isShowFavorite(context),
      child: InkWell(
          onTap: () async {

            print("${widget.logInUserId} log in id && ${widget.adsUserId}");

            if(widget.logInUserId == widget.adsUserId && widget.from != 'wist_list_screen'){
              print("This is your ads");
              Utils.showSnackBar(context, "You can not add your ads to your favorite list ");

            }else{
              final result =
              await context.read<WishListCubit>().addWishList(widget.productId);

              result.fold(
                    (failure) {
                  Utils.showSnackBarWithAction(context, failure.message,(){
                    Navigator.pushNamed(context, RouteNames.authenticationScreen);
                  },actionText: "Login",textColor: primaryColor);
                  // Navigator.pushNamed(context, RouteNames.authenticationScreen);
                  Utils.errorSnackBar(context, failure.message);
                },
                    (success) {
                  setState(() {
                    widget.isFav = !widget.isFav;
                  });
                  Utils.showSnackBarWithAction(context, success, () {
                    Navigator.pushNamed(context, RouteNames.wishListScreen);
                  }, actionText: "show ads", textColor: Colors.white);
                },
              );
            }
          },
          child: widget.isFav
              ? Icon(
            Icons.favorite,
            color: Colors.grey.shade800,
            size: 20,
          )
              : Icon(
            Icons.favorite_outline,
            color: Colors.grey.shade500,
            size: 20,
          )
      ),
    );
  }
}
