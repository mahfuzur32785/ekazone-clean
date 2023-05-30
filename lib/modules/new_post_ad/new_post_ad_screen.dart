import 'dart:async';

import 'package:ekayzone/modules/ad_details/model/ad_details_model.dart';
import 'package:ekayzone/modules/price_planing/plan_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ekayzone/core/router_name.dart';
import 'package:ekayzone/modules/authentication/controllers/login/login_bloc.dart';
import 'package:ekayzone/modules/new_post_ad/component/category_chooser.dart';
import 'package:ekayzone/utils/constants.dart';

import '../../utils/utils.dart';
import '../post_ad/controller/postad_bloc.dart';
import '../home/model/pricing_model.dart';
import 'component/new_basic_info.dart';
import 'controller/new_posted_bloc.dart';

class NewPostAdScreen extends StatefulWidget {
  const NewPostAdScreen({Key? key}) : super(key: key);

  @override
  State<NewPostAdScreen> createState() => _NewPostAdScreenState();
}

class _NewPostAdScreenState extends State<NewPostAdScreen> with TickerProviderStateMixin{

  //https://res.cloudinary.com/hilnmyskv/image/upload/f_auto,q_70,w_1234/v1668022960/Algolia_com_Website_assets/images/homepage/banner-image.png

  late List<Widget> pageList;
  final naveListener = StreamController<int>.broadcast();
  late AnimationController _animationController;
  late Animation<double> _animOffset;

  late AdDetails adDetailsModel;

  @override
  void initState() {
    context.read<NewPostAdBloc>().add(const NewPostAdEventEmpty());
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    final curve = CurvedAnimation(curve: Curves.decelerate, parent: _animationController);
    _animOffset = Tween<double>(begin: 0.5, end: 1).animate(curve);
    _animationController.forward();
    pageList = [
      NewAdPostCategoryChooser(onPressed: (){
        naveListener.sink.add(1);
        _animationController.forward(from: 0.0);
      },),
      const NewBasicInfoView(),
      // ContactInfoView(),
      // FeatureImageView()
    ];
    super.initState();
  }

  @override
  void didUpdateWidget(NewPostAdScreen oldWidget) {
    if (widget != oldWidget) {
      _animationController.forward(from: 0.0);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final postAdBloc = context.read<NewPostAdBloc>();
    final loginBloc = context.read<LoginBloc>();
    return BlocListener<NewPostAdBloc, NewPostAdModalState>(
      listenWhen: (previous, current) => previous.state != current.state,
      listener: (context, state) {
        if (state.state is NewPostAdStateError) {
          Utils.closeDialog(context);
          final status = state.state as NewPostAdStateError;
          Utils.errorSnackBar(context, status.errorMsg);
        }
        if (state.state is NewPostAdStateLoading) {
          Utils.loadingDialog(context);
        }
        if (state.state is NewPostAdStateLoaded) {
          final adDetails = state.state as NewPostAdStateLoaded;
          adDetailsModel = adDetails.adDetails;
          Utils.closeDialog(context);
          final status = state.state as NewPostAdStateLoaded;
          Utils.showSnackBar(context, status.message);
          if(!postAdBloc.isPaymentChecked) {
            Future.delayed(const Duration(seconds: 1)).then((value) {
              Navigator.of(context).pop();
            });
          }
          if(postAdBloc.isPaymentChecked){
            Navigator.pushNamed(context, RouteNames.planDetailsScreen, arguments: PlanDetailsScreenArguments(adDetailsModel, postAdBloc.id, postAdBloc.title, postAdBloc.price)).then((value){
              Navigator.pop(context);
            });
          }
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
          //     state: const NewPostAdStateInitial());
        }

        //........... Custom Fields Data .............
        // if (state.state is NewPostAdStateCustomFiledDataError) {
        //   Utils.closeDialog(context);
        //   final status = state.state as NewPostAdStateCustomFiledDataError;
        //   Utils.errorSnackBar(context, status.errorMsg);
        // }
        // if (state.state is NewPostAdStateCustomFiledDataLoading) {
        //   Utils.loadingDialogWithText(context,text: "Loading additional fields..");
        // }
        // if (state.state is NewPostAdStateCustomFiledDataLoaded) {
        //   Utils.closeDialog(context);
        // }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Ad post",style: const TextStyle(color: Colors.white),),
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
                  Expanded(
                    child: FadeTransition(
                      opacity: _animationController,
                      child: IndexedStack(
                        index: index,
                        children: pageList,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: index == 1,
                    child: Container(
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
                                  Navigator.pushNamed(context, RouteNames.privacyPolicyScreen);
                                },
                                child: FadeTransition(
                                    opacity: _animationController,
                                    child: Text('View rules',style: const TextStyle(color: redColor),)
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
                              child: BlocBuilder<NewPostAdBloc, NewPostAdModalState>(
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

                                        print('Gallery image is length: ${postAdBloc.state.images.length}');

                                        if (postAdBloc.featureFormKey.currentState!.validate()){
                                          if(postAdBloc.isPaymentChecked){
                                            if(postAdBloc.price.isNotEmpty) {
                                              print(
                                                  "Redirect in payment screen");

                                              Utils.closeKeyBoard(context);
                                              postAdBloc.add(
                                                  NewPostAdEventSubmit(
                                                      loginBloc.userInfo!
                                                          .accessToken));
                                            }else{
                                              Utils.showSnackBar(context, "Select Your Plan");
                                            }
                                          }
                                          else{
                                            Utils.closeKeyBoard(context);
                                            postAdBloc.add(NewPostAdEventSubmit(loginBloc.userInfo!.accessToken));
                                          }
                                          // if (postAdBloc.state.images.isEmpty) {
                                          //   Utils.errorSnackBar(context, "You must upload 1 image");
                                          // } else {
                                          //   // Utils.loadingDialog(context);
                                          //   postAdBloc.add(NewPostAdEventSubmit(loginBloc.userInfo!.accessToken));
                                          // }
                                        }
                                      },
                                      child: Text(index == 1 ? 'Post ad' : "Next step",style: const TextStyle(color: Colors.white),),
                                    );
                                  }
                              ),
                            ),
                          ),
                        ],
                      ),
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
