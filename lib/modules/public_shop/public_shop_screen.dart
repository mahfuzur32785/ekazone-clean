import 'package:ekayzone/modules/home/component/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../core/remote_urls.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';
import '../../widgets/custom_image.dart';
import '../authentication/controllers/login/login_bloc.dart';
import '../profile/controller/public_profile/public_profile_cubit.dart';
import 'component/seller_info.dart';

class MyShopScreen extends StatefulWidget {
  const MyShopScreen({Key? key, required this.username}) : super(key: key);
  final String username;

  @override
  State<MyShopScreen> createState() => _MyShopScreenState();
}

class _MyShopScreenState extends State<MyShopScreen> {
  bool shopSelect = true;
  bool sellerReviewSelect = false;
  bool writeReviewSelect = false;

  final reviewController = TextEditingController();

  String? selectedValue;
  var ratings = 0.0;

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<PublicProfileCubit>().getPublicProfile(widget.username, ''));
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    final userData = context.read<LoginBloc>().userInfo;
    final bloc = context.read<PublicProfileCubit>();

    return Scaffold(
        backgroundColor: const Color(0xFFF6F7FE),
        appBar: AppBar(
          title: Text(widget.username.toString() == userData?.user.username.toString() ? "My Shop" : widget.username),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_sharp,
              color: iconThemeColor,
            ),
          ),
        ),
        body: BlocBuilder<PublicProfileCubit, PublicProfileState>(
          builder: (context, state) {
            if (state is PublicProfileStateLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is PublicProfileStateError) {
              return Center(
                child: Text(state.message),
              );
            }
            if (state is PublicProfileStateLoaded) {
              return RefreshIndicator(
                key: _refreshIndicatorKey,
                onRefresh: () => context.read<PublicProfileCubit>().getPublicProfile(widget.username, ''),
                child: CustomScrollView(
                  slivers: [
                    ///SELLER INFO SECTION
                    SliverPadding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      sliver: SliverToBoxAdapter(
                        child: SellerInfo(publicProfileModel: state.data),
                      ),
                    ),

                    SliverPadding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      sliver: SliverToBoxAdapter(
                        child: Column(
                          children: [
                            ///BUTTONS SECTIONS
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          shopSelect = true;
                                          sellerReviewSelect = false;
                                          writeReviewSelect = false;
                                        });
                                      },
                                      child: Container(
                                        height: 48,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: shopSelect
                                              ? redColor
                                              : Colors.transparent,
                                          borderRadius: BorderRadius.circular(30),
                                          // border: Border.all(color: Colors.grey.shade300),
                                        ),
                                        child: Text("Shop",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: shopSelect
                                                  ? Colors.white
                                                  : Colors.black,
                                            )),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          shopSelect = false;
                                          sellerReviewSelect = true;
                                          writeReviewSelect = false;
                                        });
                                      },
                                      child: Container(
                                        height: 48,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: sellerReviewSelect
                                              ? redColor
                                              : Colors.transparent,
                                          borderRadius: BorderRadius.circular(30),
                                          // border: Border.all(color: Colors.grey.shade300),
                                        ),
                                        child: Text("Seller Review",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: sellerReviewSelect
                                                  ? Colors.white
                                                  : Colors.black,
                                            )),
                                      ),
                                    ),
                                  ),
                                  bloc.isMe(state.data.user.id) ? const SizedBox() : Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          shopSelect = false;
                                          sellerReviewSelect = false;
                                          writeReviewSelect = true;
                                        });
                                      },
                                      child: Container(
                                        height: 48,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: writeReviewSelect
                                              ? redColor
                                              : Colors.transparent,
                                          borderRadius: BorderRadius.circular(30),
                                          // border: Border.all(color: Colors.grey.shade300),
                                        ),
                                        child: Text(
                                          "Write Review",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: writeReviewSelect
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),

                            const SizedBox(
                              height: 20,
                            ),

                            LayoutBuilder(
                              builder: (p0, p1) {
                                if (shopSelect) {
                                  return state.data.recentAds.isNotEmpty? Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 20),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                            BorderRadius.circular(5),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.4),
                                                  offset: const Offset(0, 0),
                                                  blurRadius: 3),
                                            ]),
                                        child: Column(
                                          children: [
                                            Text(
                                              "${state.data.recentAds.length} Item Available Listings",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  "Sort By: ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w600),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    height: 40,
                                                    padding: const EdgeInsets
                                                        .symmetric(horizontal: 5),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors
                                                                .grey.shade400),
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                    child:
                                                    DropdownButtonHideUnderline(
                                                      child:
                                                      DropdownButton<String>(
                                                        hint: const Text(
                                                            'Sort By',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black)),
                                                        isDense: true,
                                                        isExpanded: true,
                                                        onChanged:
                                                            (dynamic value) {
                                                          selectedValue = value;
                                                          bloc.getPublicProfile(widget.username, selectedValue);
                                                          print(selectedValue);
                                                          setState(() {});
                                                        },
                                                        value: selectedValue,
                                                        items: myItemSortListData
                                                            .map((location) {
                                                          return DropdownMenuItem<String>(
                                                            value: location['value'],
                                                            child: Text("${location['name']}"),
                                                          );
                                                        }).toList(),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 20,),
                                      SizedBox(
                                        height: MediaQuery.of(context)
                                            .size
                                            .height,
                                        child: GridView.builder(
                                            physics: const NeverScrollableScrollPhysics(),
                                            gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                crossAxisSpacing: 10,
                                                mainAxisSpacing: 10),
                                            itemBuilder: (context, index) {
                                              return ProductCard(
                                                adModel: state.data.recentAds[index],
                                                from: 'public_shop',
                                                myId: userData?.user.id,
                                                sellerId: state.data.recentAds[index].userId,
                                                logInUserId: userData?.user.id,
                                              );
                                            },
                                            itemCount: state
                                                .data.recentAds.length),
                                      )
                                    ],
                                  ): SizedBox(
                                    height: 100,
                                    width: double.infinity,
                                    child: Center(
                                      child: Container(
                                          padding: const EdgeInsets
                                              .symmetric(
                                              horizontal: 16,
                                              vertical: 8),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  6),
                                              border: Border.all(
                                                  color:
                                                  Colors.black54)),
                                          child: const Text(
                                            "No Ads Found",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 16,
                                                fontWeight:
                                                FontWeight.w500),
                                          )),
                                    ),
                                  );
                                }

                                if (sellerReviewSelect) {
                                  if (state.data.reviewList.isNotEmpty) {
                                    return SizedBox(
                                        height:
                                        MediaQuery.of(context).size.height,
                                        child: ListView.separated(
                                          itemBuilder: (context, index) {
                                            ratings = double.parse(state.data.reviewList[index].stars);
                                            reviewController.text = state.data.reviewList[index].comment;
                                            return Container(
                                              padding: const EdgeInsets.all(16),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(10),
                                                color: Colors.white,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      CircleAvatar(
                                                        radius: 30,
                                                        backgroundColor:
                                                        Colors.grey.shade300,
                                                        backgroundImage: NetworkImage(
                                                            "${state.data.reviewList[index].user.imageUrl}"),
                                                      ),
                                                      // CustomImage(path: state.data.reviewList[index].user.imageUrl,width: 80,height: 50,color: Colors.grey.shade300,),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Text(
                                                            state
                                                                .data
                                                                .reviewList[index]
                                                                .user
                                                                .username,
                                                            style: const TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                          ),
                                                          RatingBar.builder(
                                                            initialRating:
                                                            double.parse(state
                                                                .data
                                                                .reviewList[
                                                            index]
                                                                .stars),
                                                            minRating: 1,
                                                            direction:
                                                            Axis.horizontal,
                                                            allowHalfRating:
                                                            false,
                                                            itemCount: 5,
                                                            itemSize: 20,
                                                            itemPadding:
                                                            const EdgeInsets
                                                                .only(
                                                                right: 2),
                                                            itemBuilder:
                                                                (context, _) =>
                                                            const Icon(
                                                              Icons.star_border,
                                                              color: Color(
                                                                  0xffF0A732),
                                                              // size: 5,
                                                            ),
                                                            onRatingUpdate:
                                                                (rating) {},
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 12,
                                                  ),
                                                  Text(
                                                    state.data.reviewList[index]
                                                        .comment,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          itemCount: state.data.reviewList.length,
                                          physics:
                                          const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          separatorBuilder:
                                              (BuildContext context, int index) {
                                            return const SizedBox(
                                              height: 10,
                                            );
                                          },
                                        ));
                                  } else {
                                    return SizedBox(
                                      height: 100,
                                      width: double.infinity,
                                      child: Center(
                                        child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 8),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(6),
                                                border: Border.all(
                                                    color: Colors.black54)),
                                            child: const Text(
                                              "No Review Found",
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            )),
                                      ),
                                    );
                                  }
                                }

                                if (writeReviewSelect) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border:
                                      Border.all(color: Colors.grey.shade300),
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        RatingBar.builder(
                                          initialRating: ratings,
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: false,
                                          itemCount: 5,
                                          itemSize: 20,
                                          itemPadding:
                                          const EdgeInsets.only(right: 2),
                                          itemBuilder: (context, _) => const Icon(
                                            Icons.star_border,
                                            color: Color(0xffF0A732),
                                            // size: 5,
                                          ),
                                          onRatingUpdate: (rating) {
                                            setState(() {
                                              ratings = rating;
                                            });
                                            print(rating);
                                          },
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(5),
                                                  borderSide: const BorderSide(
                                                      color: Colors.grey),
                                                ),
                                                hintText: "Write your review"),
                                            controller: reviewController,
                                            maxLines: 5,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 45,
                                          width: 120,
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              if (userData != null) {
                                                if (ratings > 0 && reviewController.text != '') {
                                                  final body = <String, dynamic>{};
                                                  body.addAll({"stars": ratings.toString()});
                                                  body.addAll({"comment": reviewController.text.trim()});
                                                  Utils.loadingDialog(context);
                                                  final result = await bloc.profileRepository.postSellerReview(body, widget.username, userData.accessToken);
                                                  result.fold((l) {
                                                    Utils.closeDialog(context);
                                                    Utils.showSnackBar(context, l.message);
                                                  }, (r) {
                                                    Utils.closeDialog(context);
                                                    reviewController.text = '';
                                                    ratings = -1;
                                                    Utils.showSnackBar(context, r);
                                                    bloc.getPublicProfile(widget.username, '');
                                                  });
                                                } else {
                                                  Utils.showSnackBar(context, "Give rating and write review");
                                                }
                                              } else {
                                                Utils.openSignInDialog(context);
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(5),
                                                ),
                                                backgroundColor:
                                                redColor,
                                                foregroundColor: Colors.white),
                                            child: Text( reviewController.text.isEmpty ? 'Save' : 'Update'),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }
                                return Container();
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            return const SizedBox();
          },
        ));
  }
}
