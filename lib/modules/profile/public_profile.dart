import 'package:ekayzone/modules/authentication/models/user_login_response_model.dart';
import 'package:ekayzone/modules/profile/controller/public_profile/public_profile_cubit.dart';
import 'package:ekayzone/utils/constants.dart';
import 'package:ekayzone/utils/utils.dart';
import 'package:ekayzone/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../core/remote_urls.dart';
import '../../dummy_data/all_dudmmy_data.dart';
import '../../utils/k_images.dart';
import '../authentication/controllers/login/login_bloc.dart';
import '../home/component/grid_product_container.dart';
import '../home/component/horizontal_ad_container.dart';
import 'model/public_profile_model.dart';

class PublicProfile extends StatefulWidget {
  const PublicProfile({Key? key, required this.username}) : super(key: key);
  final String username;

  @override
  State<PublicProfile> createState() => _PublicProfileState();
}

class _PublicProfileState extends State<PublicProfile> {

  int isAds = 1;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<PublicProfileCubit>().getPublicProfile(widget.username, ''));
  }


  final List<ButtonSegment> segments = [
    const ButtonSegment(
        value: 0,
        enabled: true,
        icon: Icon(Icons.add),
        label: Text("Recent Ads")
    ),
    const ButtonSegment(
        value: 1,
        enabled: true,
        icon: Icon(Icons.add),
        label: Text("Reviews")
    ),
    const ButtonSegment(
        value: 2,
        enabled: true,
        icon: Icon(Icons.add),
        label: Text("Write Review")
    ),
  ];

  bool isReviewShow(UserLoginResponseModel? userData, PublicProfileModel data){
    if (userData == null) {
      return false;
    }
    if (userData.user.id == data.user.id) {
      return false;
    }
    bool x = data.reviewList.any((element) => userData.user.id == element.user.id);
    if (x) {
      return false;
    }
    return true;
  }

  var reviewController = TextEditingController();
  int rating = -1;

  @override
  Widget build(BuildContext context) {
    final userData = context.read<LoginBloc>().userInfo;
    final bloc = context.read<PublicProfileCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.username),
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_sharp,color: iconThemeColor,),
        ),
      ),
      body: BlocBuilder<PublicProfileCubit,PublicProfileState>(
          builder: (context,state) {
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
              return CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    sliver: SliverToBoxAdapter(
                      child: Container(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.blueGrey.withOpacity(0.1),
                                  blurRadius: 6,
                                  offset: const Offset(1, 1))
                            ]),
                        child: Column(
                          children: [
                            const CircleAvatar(
                              radius: 80,
                              backgroundColor: ashColor,
                              backgroundImage: AssetImage(Kimages.defaultUser),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              state.data.user.name,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 20,
                                ),
                                Text(
                                  "${state.data.ratingDetails.rating} Star rating",
                                  style: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            const Divider(
                              height: 50,
                            ),
                            Text(
                              "Follow on social media",
                              style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Wrap(
                              alignment: WrapAlignment.center,
                              spacing: 8,
                              runSpacing: 8,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                ...List.generate(state.data.socialMedias.length, (index) {
                                  return Material(
                                    color: Utils.getSocialIconColor(state.data.socialMedias[index].socialMedia),
                                    shape: const CircleBorder(),
                                    child: InkWell(
                                      onTap: () {
                                        Utils.appLaunchUrl(state.data.socialMedias[index].url).then((value) {
                                          if (!value) {
                                            Utils.showSnackBar(context, "This is not a link.\n${state.data.socialMedias[index].url}");
                                          }
                                        });
                                        // Utils.appLaunchUrl('https://www.linkedin.com/in/ziaur-rahman-379ab3155/');
                                      },
                                      borderRadius: BorderRadius.circular(50),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: FaIcon(Utils.getSocialIcon(state.data.socialMedias[index].socialMedia),color: Colors.white,size: 24,),
                                      ),
                                    ),
                                  );
                                })
                              ],
                            ),
                            const Divider(
                              height: 50,
                            ),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Contact information",
                                  style: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                )
                            ),
                            Visibility(
                              visible: state.data.user.showPhone == 1,
                              child: Row(
                                children: [
                                  const Icon(Icons.call,color: Colors.green,size: 20,),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "${state.data.user.phone}",
                                    style: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                            ),
                            Visibility(
                              visible: state.data.user.showEmail == 1,
                              child: Row(
                                children: [
                                  const Icon(Icons.mail_outline,color: Colors.green,size: 20,),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    state.data.user.email,
                                    style: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                    sliver: SliverToBoxAdapter(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.blueGrey.withOpacity(0.1),
                                  blurRadius: 6,
                                  offset: const Offset(1, 1))
                            ]),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: ashColor)
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 60,
                                    width: 60,
                                    padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                                    decoration: BoxDecoration(
                                      color: Colors.red.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Center(
                                      child: Text("${state.data.ratingDetails.total}",style: const TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("${state.data.ratingDetails.average} Star average rating",style: const TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w500),),
                                        Text("${state.data.reviewList.length} People written reviews",style: const TextStyle(color: Colors.black54,fontSize: 14,fontWeight: FontWeight.w400),),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: ashColor)
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("${state.data.totalActiveAds}",style: const TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w600),),
                                        Text("Active ads",style: const TextStyle(color: Colors.black54,fontSize: 14,fontWeight: FontWeight.w400),),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Container(
                                    height: 60,
                                    width: 60,
                                    padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                                    decoration: BoxDecoration(
                                      // color: Colors.red.withOpacity(0.1),
                                      border: Border.all(color: Colors.orange),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: const Center(
                                        child: CustomImage(path: Kimages.advertisingIcon,width: 60,height: 60,)
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                    sliver: SliverToBoxAdapter(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.blueGrey.withOpacity(0.1),
                                  blurRadius: 6,
                                  offset: const Offset(1, 1))
                            ]
                        ),
                        child: Column(
                          children: [
                            // SegmentedButton(
                            //   segments: segments,
                            //   selected: segment!,
                            //   onSelectionChanged: (value){
                            //
                            //   },
                            // ),
                            Row(
                              children: [
                                Expanded(
                                  child: Material(
                                    borderRadius: BorderRadius.circular(6),
                                    color: isAds == 1 ? redColor.withOpacity(0.1) : Colors.transparent,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(6),
                                      onTap: (){
                                        setState(() {
                                          isAds = 1;
                                        });
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                colors: gradientColors[isAds == 1 ? 0 : 6]
                                            ),
                                            border: Border.all(color: redColor.withOpacity(1)),
                                            borderRadius: BorderRadius.circular(6)
                                        ),
                                        padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 8),
                                        child: Text("Recent ads",style: TextStyle(color: isAds == 1 ? Colors.white :  Colors.black,fontSize: 15,fontWeight: FontWeight.w500),),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: Material(
                                    borderRadius: BorderRadius.circular(6),
                                    color: isAds != 1 ? redColor.withOpacity(0.1) : Colors.transparent,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(6),
                                      onTap: (){
                                        setState(() {
                                          isAds = 0;
                                        });
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                colors: gradientColors[isAds != 1 ? 0 : 6]
                                            ),
                                            border: Border.all(color: redColor.withOpacity(1)),
                                            borderRadius: BorderRadius.circular(6)
                                        ),
                                        padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 8),
                                        child: Text("Seller review",style: TextStyle(color: isAds != 1 ? Colors.white : Colors.black,fontSize: 15,fontWeight: FontWeight.w500),),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            LayoutBuilder(
                                builder: (context,constraints) {
                                  if (isAds == 1) {
                                    return HorizontalProductContainer(
                                      adModelList: state.data.recentAds,
                                      title: "",
                                      onPressed: (){},
                                    );
                                  } else {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Visibility(
                                          visible: isReviewShow(userData,state.data),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                            margin: const EdgeInsets.symmetric(vertical: 10),
                                            decoration: BoxDecoration(
                                                border: Border.all(color: ashColor),
                                                borderRadius: BorderRadius.circular(6)
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Text("Write Your Review",style: TextStyle(fontSize: 16),),
                                                Row(
                                                  children: [
                                                    ...List.generate(5, (index) {
                                                      return Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 10),
                                                        child: GestureDetector(
                                                            onTap: (){
                                                              setState(() {
                                                                rating = index;
                                                              });
                                                            },
                                                            child: Icon(index <= rating ? Icons.star : Icons.star_border,color: Colors.amber,)
                                                        ),
                                                      );
                                                    })
                                                  ],
                                                ),
                                                TextFormField(
                                                  maxLines: 3,
                                                  controller: reviewController,
                                                  decoration: const InputDecoration(
                                                      hintText: "Write Review"
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 16,
                                                ),
                                                SizedBox(
                                                  height: 45,
                                                  child: ElevatedButton(
                                                      onPressed: () async {
                                                        if (userData != null) {
                                                          if (rating > -1 && reviewController.text != '') {
                                                            final body = <String, String>{};
                                                            body.addAll({"stars": '${rating+1}'});
                                                            body.addAll({"comment": reviewController.text.trim()});
                                                            Utils.loadingDialog(context);
                                                            final result = await bloc.profileRepository.postSellerReview(body, state.data.user.username, userData.accessToken);
                                                            result.fold((l) {
                                                              Utils.closeDialog(context);
                                                              Utils.showSnackBar(context, l.message);
                                                            }, (r) {
                                                              Utils.closeDialog(context);
                                                              reviewController.text = '';
                                                              rating = -1;
                                                              Utils.showSnackBar(context, r);
                                                              bloc.getPublicProfile(widget.username, '');
                                                            });
                                                          } else {
                                                            Utils.showSnackBar(context, "Give Rating and write review");
                                                          }
                                                        } else {
                                                          Utils.openSignInDialog(context);
                                                        }
                                                      },
                                                      child: const Text("Publish Review")
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        ConstrainedBox(
                                          constraints: const BoxConstraints(
                                            minHeight: 380,
                                          ),
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemBuilder: ((context, index) {
                                              return Container(
                                                margin: const EdgeInsets.symmetric(vertical: 8),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        CircleAvatar(
                                                          radius: 35,
                                                          child: ClipRRect(
                                                            borderRadius: BorderRadius.circular(100),
                                                            child: CustomImage(
                                                              // path: RemoteUrls.imageUrl(productModel.image),
                                                                path: state.data.reviewList[index].user.image != '' ? '${RemoteUrls.rootUrl}${state.data.reviewList[index].user.image}' : null,
                                                                fit: BoxFit.cover
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 8,
                                                        ),
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Text("(${state.data.reviewList[index].stars})"),
                                                                  const Icon(Icons.star)
                                                                ],
                                                              ),
                                                              SizedBox(child: Text(state.data.reviewList[index].user.name,maxLines: 1,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)),
                                                              Visibility(
                                                                  visible: true,
                                                                  child: SizedBox(child: Text(state.data.reviewList[index].comment,maxLines: 3,style: const TextStyle(color: Colors.black54,fontWeight: FontWeight.w500),))),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }),
                                            itemCount: state.data.reviewList.length,
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                }
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              );
            }
            return const SizedBox();
          }
      ),
    );
  }
}
