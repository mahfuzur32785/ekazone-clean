import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ekayzone/core/animation/custom_delayed_animation.dart';
import 'package:ekayzone/core/router_name.dart';
import 'package:ekayzone/modules/authentication/controllers/login/login_bloc.dart';
import 'package:ekayzone/modules/post_ad/component/contact_info.dart';
import 'package:ekayzone/modules/post_ad/component/feature_image.dart';
import 'package:ekayzone/modules/post_ad/controller/postad_bloc.dart';
import 'package:ekayzone/utils/constants.dart';

import '../../utils/utils.dart';
import 'component/basic_info.dart';

class PostAdScreen extends StatefulWidget {
  const PostAdScreen({Key? key}) : super(key: key);

  @override
  State<PostAdScreen> createState() => _PostAdScreenState();
}

class _PostAdScreenState extends State<PostAdScreen> with TickerProviderStateMixin{

  //https://res.cloudinary.com/hilnmyskv/image/upload/f_auto,q_70,w_1234/v1668022960/Algolia_com_Website_assets/images/homepage/banner-image.png

  late List<Widget> pageList;
  final naveListener = StreamController<int>.broadcast();
  late AnimationController _animationController;
  late Animation<double> _animOffset;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    final curve = CurvedAnimation(curve: Curves.decelerate, parent: _animationController);
    _animOffset = Tween<double>(begin: 0.5, end: 1).animate(curve);
    _animationController.forward();
    pageList = const [
      BasicInfoView(),
      // ContactInfoView(),
      FeatureImageView()
    ];
    super.initState();
  }

  @override
  void didUpdateWidget(PostAdScreen oldWidget) {
    if (widget != oldWidget) {
      _animationController.forward(from: 0.0);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final postAdBloc = context.read<PostAdBloc>();
    final loginBloc = context.read<LoginBloc>();
    return BlocListener<PostAdBloc, PostAdModalState>(
      listenWhen: (previous, current) => previous.state != current.state,
      listener: (context, state) {
        if (state.state is PostAdStateError) {
          Utils.closeDialog(context);
          final status = state.state as PostAdStateError;
          Utils.errorSnackBar(context, status.errorMsg);
        }
        if (state.state is PostAdStateLoading) {
          Utils.loadingDialog(context);
        }
        if (state.state is PostAdStateLoaded) {
          Utils.closeDialog(context);
          final status = state.state as PostAdStateLoaded;
          Utils.showSnackBar(context, status.message);
          Future.delayed(const Duration(seconds: 1)).then((value){
            Navigator.of(context).pop();
          });
          // state.copyWith(
          //     name: "",
          //     price: "",
          //     category: "",
          //     subCategory: "",
          //     phone: "",
          //     isShowPhone: false,
          //     backupPhone: "",
          //     weChat: "",
          //     description: "",
          //     features: [],
          //     location: "",
          //     images: [],
          //     brand: "",
          //     state: const PostAdStateInitial());
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Ad post",style: TextStyle(color: Colors.white),),
          backgroundColor: redColor,
          iconTheme: const IconThemeData(color: Colors.white),
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_outlined,color: Colors.white,),
          ),
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: redColor,
              statusBarIconBrightness: Brightness.light),
        ),
        body: StreamBuilder(
            initialData: 0,
            stream: naveListener.stream,
            builder: (context, AsyncSnapshot<int> snapshot) {
              int index = snapshot.data ?? 0;
              return Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 6,
                            offset: const Offset(1,1)
                        )
                      ]
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const SizedBox(
                                  width: 0,
                                ),
                                Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: index > -1 ? redColor : iconGreyColor,
                                    ),
                                    child: Icon(Icons.layers_outlined,color: index > -1 ? whiteColor : blackColor,size: 20,)
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: 2,
                                    width: 40,
                                    color: index > 0 ? redColor : iconGreyColor,
                                  ),
                                ),
                              ],
                            ),
                            Text("Basic info",textAlign: TextAlign.left,
                              style: TextStyle(color: index > -1 ? redColor : iconGreyColor,fontSize: 10),),
                          ],
                        ),
                      ),
                      // Expanded(
                      //   flex: 1,
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     children: [
                      //       Row(
                      //         children: [
                      //           const SizedBox(
                      //             width: 0,
                      //           ),
                      //           Expanded(
                      //             flex: 1,
                      //             child: Container(
                      //               height: 2,
                      //               width: 40,
                      //               color: index > 0 ? redColor : iconGreyColor,
                      //             ),
                      //           ),
                      //           Container(
                      //               padding: const EdgeInsets.all(4),
                      //               decoration: BoxDecoration(
                      //                 shape: BoxShape.circle,
                      //                 color: index > 0 ? redColor : iconGreyColor,
                      //               ),
                      //               child: Icon(Icons.phone,color: index > 0 ? whiteColor : blackColor,size: 20,)
                      //           ),
                      //           Expanded(
                      //             flex: 1,
                      //             child: Container(
                      //               height: 2,
                      //               width: 40,
                      //               color: index > 1 ? redColor : iconGreyColor,
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //       Text("Contact Info",textAlign: TextAlign.left,
                      //         style: TextStyle(color: index > 0 ? redColor : iconGreyColor,fontSize: 10),),
                      //     ],
                      //   ),
                      // ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                const SizedBox(
                                  width: 0,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: 2,
                                    width: 40,
                                    color: index > 0 ? redColor : iconGreyColor,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: index > 0 ? redColor : iconGreyColor,
                                  ),
                                    child: Icon(Icons.rocket,color: index > 0 ? whiteColor : blackColor,size: 20,)
                                ),
                              ],
                            ),
                            Text("Features, Images",textAlign: TextAlign.left,
                              style: TextStyle(color: index > 0 ? redColor : iconGreyColor,fontSize: 10),),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: FadeTransition(
                    opacity: _animationController,
                    child: IndexedStack(
                      index: index,
                      children: pageList,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 6,
                        offset: const Offset(1,1)
                      )
                    ]
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 45,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(side: const BorderSide(color: redColor,),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
                            onPressed: (){
                              if (index > 0) {
                                naveListener.sink.add(index-1);
                                _animationController.forward(from: 0.0);
                              } else {
                                Navigator.pushNamed(context, RouteNames.privacyPolicyScreen);
                              }
                            },
                            child: FadeTransition(
                                opacity: _animationController,
                                child: Text(index > 0 ? 'Previous' : "View Rules",style: const TextStyle(color: redColor),)
                            ),
                            // child: CustomDelayedAnimation(
                            //     dx: 0,
                            //     dy: 0,
                            //     delay: 50,
                            //     child: Text(index > 0 ? 'Previous' : "View Rules",style: const TextStyle(color: redColor),)
                            // ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 45,
                          child: BlocBuilder<PostAdBloc, PostAdModalState>(
                              buildWhen: (previous, current) => previous.state != current.state,
                              builder: (context, state) {
                                if (state.state is PostAdStateLoading) {
                                  return const Center(child: SizedBox(
                                    height: 24,
                                      width: 24,
                                      child: CircularProgressIndicator()));
                                }
                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
                                onPressed: (){
                                  if (loginBloc.userInfo == null) {
                                    Utils.errorSnackBar(context, "Sign in first");
                                    return;
                                  }
                                  if (index == 0) {
                                    if (postAdBloc.basicFormKey.currentState!.validate()) {
                                      naveListener.sink.add(index+1);
                                      _animationController.forward(from: 0.0);
                                    }
                                  } else if (index == 1) {
                                    if (postAdBloc.featureFormKey.currentState!.validate()){
                                      if (postAdBloc.state.images.isEmpty) {
                                        Utils.errorSnackBar(context, "You must upload 1 image");
                                      } else {
                                        // Utils.loadingDialog(context);
                                        postAdBloc.add(PostAdEventSubmit(loginBloc.userInfo!.accessToken));
                                      }
                                    }
                                  }
                                },
                                child: Text(index == 1 ? 'Post_ad' : "Next step",style: const TextStyle(color: Colors.white),),
                              );
                            }
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          }
        ),
      ),
    );
  }
}
