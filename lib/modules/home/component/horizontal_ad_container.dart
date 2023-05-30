import 'package:carousel_slider/carousel_slider.dart';
import 'package:ekayzone/modules/authentication/controllers/login/login_bloc.dart';
import 'package:ekayzone/modules/dashboard/component/dashboardlist_product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/ad_model.dart';
import 'list_product_card.dart';

class HorizontalProductContainer extends StatefulWidget {
  const HorizontalProductContainer({Key? key,this.from, required this.adModelList, required this.title, required this.onPressed}) : super(key: key);
  final List<AdModel> adModelList;
  final String title;
  final String? from;
  final Function onPressed;

  @override
  State<HorizontalProductContainer> createState() => _HorizontalProductContainerState();
}

class _HorizontalProductContainerState extends State<HorizontalProductContainer> {

  CarouselController carouselController = CarouselController();

  bool isNextTap = false;
  bool isPreviousTap = false;

  void _onTapNextDown(TapDownDetails details) {
    setState(() {
      isNextTap = true;
    });
  }

  void _onTapNextUp(TapUpDetails details) {
    Future.delayed(const Duration(milliseconds: 50)).then((value) {
      setState(() {
        isNextTap = false;
      });
    });
  }

  void _onTapPreviousDown(TapDownDetails details) {
    setState(() {
      isPreviousTap = true;
    });
  }

  void _onTapPreviousUp(TapUpDetails details) {
    Future.delayed(const Duration(milliseconds: 50)).then((value) {
      setState(() {
        isPreviousTap = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    final logInBloc = context.read<LoginBloc>();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.title,style: GoogleFonts.lato(fontSize: 18,
                  height: 1.5,
                  fontWeight: FontWeight.w600,
              ),),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      carouselController.previousPage();
                    },
                    onTapDown: _onTapPreviousDown,
                    onTapUp: _onTapPreviousUp,
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.grey.shade300),
                        color: isPreviousTap ? const Color(0xFF212d6e) : Colors.white,
                      ),
                      child: Icon(Icons.arrow_back,size: 18, color: isPreviousTap ? Colors.white : const Color(0xFF212d6e),),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  GestureDetector(
                    onTap: () {
                      carouselController.nextPage();
                    },
                    onTapDown: _onTapNextDown,
                    onTapUp: _onTapNextUp,
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.grey.shade300),
                        color: isNextTap ? const Color(0xFF212d6e) : Colors.white,
                      ),
                      child: Icon(Icons.arrow_forward,size: 18,color: isNextTap ? Colors.white : const Color(0xFF212d6e),),
                    ),
                  )
                ],
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            // height: 220,
            // color: Colors.red,
            child: LayoutBuilder(
                builder: (context,constraints) {
                  // print("Length is ${widget.adModelList.length}");
                  if (widget.adModelList.isEmpty) {
                    return SizedBox(
                      height: 100,
                      width: double.infinity,
                      child: Center(
                        child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: Colors.black54)
                            ),
                            child: const Text("Ads not found",style: TextStyle(color: Colors.black54,fontSize: 16,fontWeight: FontWeight.w500),)),
                      ),
                    );
                  }
                  return SizedBox(
                    height: 220,
                    child: CarouselSlider.builder(
                      itemBuilder: (context, index, realIndex) {
                        // print("Featured ads length ${widget.adModelList.length}");
                        if(widget.from == "Dashboard"){
                          return DashboardListProductCard(adModel: widget.adModelList[index]);
                        }
                        else if(widget.from =="home") {
                          return ListProductCard(adModel: widget.adModelList[index], index: index, logInUserId: logInBloc.userInfo?.user.id, form: 'home',);
                        }
                        else if(widget.from == 'details_page'){
                          return ListProductCard(adModel: widget.adModelList[index], index: index, logInUserId: logInBloc.userInfo?.user.id, form: 'home',);
                        }
                        return const SizedBox();
                      },
                      itemCount: widget.adModelList.length,
                      options: CarouselOptions(
                        scrollDirection: Axis.horizontal,
                        autoPlay: false,
                        viewportFraction: 1.5,
                      ),
                      carouselController: carouselController,
                    ),
                  );
                }
            ),
          )
        ],
      ),
    );
  }

}
