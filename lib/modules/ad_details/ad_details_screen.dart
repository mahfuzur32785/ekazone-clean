import 'package:ekayzone/modules/animated_splash/controller/app_setting_cubit.dart';
import 'package:ekayzone/modules/home/controller/cubit/home_controller_cubit.dart';
import 'package:ekayzone/modules/profile/controller/public_profile/public_profile_cubit.dart';
import 'package:ekayzone/widgets/custom_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ekayzone/core/router_name.dart';
import 'package:ekayzone/modules/ad_details/component/image_slider.dart';
import 'package:ekayzone/modules/ad_details/controller/ad_details_cubit.dart';
import 'package:ekayzone/modules/ad_details/controller/ad_details_state.dart';
import 'package:ekayzone/modules/authentication/controllers/login/login_bloc.dart';
import 'package:ekayzone/utils/extensions.dart';
import 'package:ekayzone/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/remote_urls.dart';
import '../../utils/constants.dart';
import '../home/component/horizontal_ad_container.dart';

class AdDetailsScreen extends StatefulWidget {
  const AdDetailsScreen({Key? key, required this.slug}) : super(key: key);
  final String slug;

  @override
  State<AdDetailsScreen> createState() => _AdDetailsScreenState();
}

class _AdDetailsScreenState extends State<AdDetailsScreen> {

  final scrollController = ScrollController(
    initialScrollOffset: 0.0,
    keepScrollOffset: true,
  );

  @override
  void initState() {
    if (kDebugMode) {
      print(widget.slug);
    }
    super.initState();
    Future.microtask(
        () => context.read<AdDetailsCubit>().getAdDetails(widget.slug, true, context.read<AppSettingCubit>().location.isEmpty ? context.read<AppSettingCubit>().defaultLocation.toString() :  context.read<AppSettingCubit>().location));
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  final _className = 'ProductDetailsScreen';

  bool isTap = false;
  // bool isClick = false;
  void _onTapDown(TapDownDetails details) {
    setState(() {
      isTap = true;
    });
  }

  void _onTapUp(TapUpDetails details) {
    Future.delayed(const Duration(milliseconds: 100)).then((value) {
      setState(() {
        isTap = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final userData = context.read<LoginBloc>().userInfo;
    final bloc = context.read<PublicProfileCubit>();

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FE),
      appBar: AppBar(
        title: const Text("Ad details"),
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
      body: BlocBuilder<AdDetailsCubit, AdDetailsState>(
          builder: (context, state) {
        if (state is AdDetailsStateLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is AdDetailsStateError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: redColor),
            ),
          );
        }
        if (state is AdDetailsStateLoaded) {
          state.adDetailsResponseModel.adDetails.id.toString().log();
          state.adDetailsResponseModel.adDetails.wishListed.toString().log();
          return CustomScrollView(
            slivers: [
              //IMAGE SLIDER
              SliverToBoxAdapter(
                child: ImageSlider(
                  gallery: state.adDetailsResponseModel.adDetails.galleries,
                  height: MediaQuery.of(context).size.width * 0.8,
                  adDetails: state.adDetailsResponseModel.adDetails,
                ),
              ),
              SliverPadding(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                sliver: SliverToBoxAdapter(
                  child: InkWell(
                    onTap: () {
                      if(bloc.isMe(state.adDetailsResponseModel.adDetails.customer?.id)) {
                        Utils.showSnackBar(context, "You can not report with your ads");
                      }else{
                        showReportDialog(context,state.adDetailsResponseModel.adDetails.id);
                      }
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.report,size: 20,),
                        SizedBox(width: 5),
                        Text("Report this ad")
                      ],
                    ),
                  ),
                ),
              ),

              ///ADS DETAILS AND SHARE OPTIONS
              SliverPadding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                sliver: SliverToBoxAdapter(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              offset: const Offset(0, 0),
                              blurRadius: 3),
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: double.infinity,
                        ),
                        Visibility(
                          visible: state.adDetailsResponseModel.adDetails.price.isNotEmpty,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              "${context.read<HomeControllerCubit>().symbol} ${state.adDetailsResponseModel.adDetails.price}",
                              style: GoogleFonts.lato(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            state.adDetailsResponseModel.adDetails.title,
                            style: GoogleFonts.lato(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                height: 1),
                          ),
                        ),

                        Row(
                          children: [
                            Transform.rotate(
                                angle: -5,
                                child: const Icon(
                                  Icons.local_offer_outlined,
                                  size: 16,
                                  color: Colors.black54,
                                )),
                            Text(
                              "Category: ${state.adDetailsResponseModel.adDetails.category!.name}",
                              style: GoogleFonts.lato(
                                  fontSize: 14, color: Colors.black54),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Transform.rotate(
                                angle: 0,
                                child: const Icon(
                                  Icons.local_movies_outlined,
                                  size: 14,
                                  color: Colors.black54,
                                )),
                            Expanded(
                              child: SizedBox(
                                child: Text(
                                  "Sub-Category: ${state.adDetailsResponseModel.adDetails.subcategory?.name}",
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54),
                                  maxLines: 1,overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 16,
                              color: Colors.black54,
                            ),
                            Text(
                              "Location: ${state.adDetailsResponseModel.adDetails.city}",
                              style: GoogleFonts.lato(
                                  fontSize: 14, color: Colors.black54),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.post_add,
                              size: 16,
                              color: Colors.black54,
                            ),
                            Text(
                              "Posted at: ${Utils.timeAgo(state.adDetailsResponseModel.adDetails.customer!.createdAt)}",
                              style: GoogleFonts.lato(
                                  fontSize: 14, color: Colors.black54),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        ///Chat with seller button
                        SizedBox(
                          height: 48,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              if (userData != null) {
                                if(bloc.isMe(state.adDetailsResponseModel
                                    .adDetails.customer?.id)){
                                  Utils.showSnackBar(context, "You can not message with yourself");
                                  return;
                                } else {
                                  Navigator.pushNamed(
                                      context, RouteNames.chatDetails,
                                      arguments: state.adDetailsResponseModel
                                          .adDetails.customer?.username??'');
                                }
                              } else {
                                Utils.openSignInDialog(context);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(2))),
                            icon: const FaIcon(FontAwesomeIcons.message,
                                size: 18),
                            label: Text(
                              "Chat With Seller",
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),

                        ///Phone button
                        Visibility(
                          visible: state.adDetailsResponseModel.adDetails.showPhone && state.adDetailsResponseModel.adDetails.phone.isNotEmpty,
                          child: SizedBox(
                            height: 48,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                // isClick = true;
                                // setState(() {
                                //
                                // });
                                phoneCall(state.adDetailsResponseModel.adDetails.phone,context);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF212d6e),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(2))),
                              icon: const FaIcon(
                                FontAwesomeIcons.phone,
                                size: 18,
                              ),
                              label: Text(
                                userData!=null ? state.adDetailsResponseModel.adDetails.phone : "Login to View Phone",
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),

                        ///Email button
                        Visibility(
                          visible: state.adDetailsResponseModel.adDetails.showEmail == '1' && state.adDetailsResponseModel.adDetails.email.isNotEmpty,
                          child: SizedBox(
                            height: 48,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                // isClick = true;
                                // setState(() {
                                //
                                // });
                                sendEmail(state.adDetailsResponseModel.adDetails.email,context);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF212d6e),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(2))),
                              icon: const FaIcon(
                                FontAwesomeIcons.envelope,
                                size: 20,
                              ),
                              label: Text(
                                userData!=null ? state.adDetailsResponseModel.adDetails.email : "Login to View Email",
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),

                        ///Whatsapp button
                        Visibility(
                          visible: state.adDetailsResponseModel.adDetails.showWhatsapp == '1' && state.adDetailsResponseModel.adDetails.whatsapp.isNotEmpty,
                          child: SizedBox(
                            height: 48,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                // isClick = true;
                                // setState(() {
                                //
                                // });
                                sendWhatsappMessage("https://api.whatsapp.com/send?phone=${state.adDetailsResponseModel.adDetails.whatsapp}&text=Hello there", context);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff1faf54),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(2))),
                              icon: const FaIcon(
                                FontAwesomeIcons.whatsapp,
                                size: 20,
                              ),
                              label: Text(
                                userData!=null ? "Send Message via whatsapp" : "Login to Chat with Whatsapp",
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),

                        const Text(
                          "Share this ad",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              "Share",
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 12),
                            ),
                            GestureDetector(
                              onTap: (){
                                Share.share(
                                    '${RemoteUrls.rootUrl}/ad/details/${state.adDetailsResponseModel.adDetails.slug}',
                                    // sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
                                    subject:
                                    'Click bellow the link to share Safestore product');
                              },
                              child: const Image(
                                image: AssetImage('assets/social/facebook.png'),
                                height: 30,
                                width: 30,
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                Share.share(
                                    '${RemoteUrls.rootUrl}/ad/details/${state.adDetailsResponseModel.adDetails.slug}',
                                    // sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
                                    subject:
                                    'Click bellow the link to share Safestore product');
                              },
                              child: const Image(
                                image: AssetImage('assets/social/twitter.png'),
                                height: 30,
                                width: 30,
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                Share.share(
                                    '${RemoteUrls.rootUrl}/ad/details/${state.adDetailsResponseModel.adDetails.slug}',
                                    // sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
                                    subject:
                                    'Click bellow the link to share Safestore product');
                              },
                              child: const Image(
                                image: AssetImage('assets/social/linkedin.png'),
                                height: 30,
                                width: 30,
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                Share.share(
                                    '${RemoteUrls.rootUrl}/ad/details/${state.adDetailsResponseModel.adDetails.slug}',
                                    // sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
                                    subject:
                                    'Click bellow the link to share Safestore product');
                              },
                              child: const Image(
                                image: AssetImage('assets/social/pinterest.png'),
                                height: 30,
                                width: 30,
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                Share.share(
                                    '${RemoteUrls.rootUrl}/ad/details/${state.adDetailsResponseModel.adDetails.slug}',
                                    // sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
                                    subject:
                                    'Click bellow the link to share Safestore product');
                              },
                              child: const Image(
                                image: AssetImage('assets/social/mail.png'),
                                height: 30,
                                width: 30,
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                Share.share(
                                    '${RemoteUrls.rootUrl}/ad/details/${state.adDetailsResponseModel.adDetails.slug}',
                                    // sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
                                    subject:
                                    'Click bellow the link to share Safestore product');
                              },
                              child: const Image(
                                image: AssetImage('assets/social/whatsapp.png'),
                                height: 30,
                                width: 30,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              ///DESCRIPTION SECTION
              SliverPadding(
                padding: const EdgeInsets.all(10),
                sliver: SliverToBoxAdapter(
                  child: Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              offset: const Offset(0, 0),
                              blurRadius: 3),
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                          visible: state.adDetailsResponseModel.adDetails.authenticity != null,
                          child: Text("Authenticity: ${state.adDetailsResponseModel.adDetails.authenticity}"),
                        ),
                        Visibility(
                          visible: state.adDetailsResponseModel.adDetails.edition != null,
                          child: Column(
                            children: [
                              const SizedBox(height: 5,),
                              Text("Edition: ${state.adDetailsResponseModel.adDetails.edition}"),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: state.adDetailsResponseModel.adDetails.brand != null,
                          child: Column(
                            children: [
                              const SizedBox(height: 5,),
                              Text("Brand: ${state.adDetailsResponseModel.adDetails.brand?.name}"),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: state.adDetailsResponseModel.adDetails.model != null,
                          child: Column(
                            children: [
                              const SizedBox(height: 5,),
                              Text("Models: ${state.adDetailsResponseModel.adDetails.model}"),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: state.adDetailsResponseModel.adDetails.vehicleManufacture != null,
                          child: Column(
                            children: [
                              const SizedBox(height: 5,),
                              Text("Manufacture Year: ${state.adDetailsResponseModel.adDetails.vehicleManufacture}"),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: state.adDetailsResponseModel.adDetails.vehicleEngineCapacity != null,
                          child: Column(
                            children: [
                              const SizedBox(height: 5,),
                              Text("Engine Capacity: ${state.adDetailsResponseModel.adDetails.vehicleEngineCapacity} Cc"),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: state.adDetailsResponseModel.adDetails.vehicleFuleType.isNotEmpty,
                          child: Column(
                            children: [
                              const SizedBox(height: 5,),
                              SizedBox(
                                child: Text("Fuel Type: ${state.adDetailsResponseModel.adDetails.vehicleFuleType}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),

                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: state.adDetailsResponseModel.adDetails.vehicleTransmission.isNotEmpty,
                          child: Column(
                            children: [
                              const SizedBox(height: 5,),
                              Text("Transmission: ${state.adDetailsResponseModel.adDetails.vehicleTransmission}"),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: state.adDetailsResponseModel.adDetails.vehicleBodyType !=null,
                          child: Column(
                            children: [
                              const SizedBox(height: 5,),
                              Text("Body Type: ${state.adDetailsResponseModel.adDetails.vehicleBodyType}"),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: state.adDetailsResponseModel.adDetails.condition != null,
                          child: Column(
                            children: [
                              const SizedBox(height: 5,),
                              Text("Condition: ${state.adDetailsResponseModel.adDetails.condition}"),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: state.adDetailsResponseModel.adDetails.textbookType != null,
                          child: Column(
                            children: [
                              const SizedBox(height: 5,),
                              Text("Textbook Type: ${state.adDetailsResponseModel.adDetails.textbookType}"),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: state.adDetailsResponseModel.adDetails.registrationYear != null,
                          child: Column(
                            children: [
                              const SizedBox(height: 5,),
                              Text("Registration Year: ${state.adDetailsResponseModel.adDetails.registrationYear}"),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: state.adDetailsResponseModel.adDetails.designation != null,
                          child: Column(
                            children: [
                              const SizedBox(height: 5,),
                              Text("Designation: ${state.adDetailsResponseModel.adDetails.designation}"),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: state.adDetailsResponseModel.adDetails.experience != null,
                          child: Column(
                            children: [
                              const SizedBox(height: 5,),
                              Text("Experience Year: ${state.adDetailsResponseModel.adDetails.experience}"),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: state.adDetailsResponseModel.adDetails.jobType != null,
                          child: Column(
                            children: [
                              const SizedBox(height: 5,),
                              Text("Type: ${state.adDetailsResponseModel.adDetails.jobType}"),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: state.adDetailsResponseModel.adDetails.required_education.isNotEmpty,
                          child: Column(
                            children: [
                              const SizedBox(height: 5,),
                              Text("Employment Type: ${state.adDetailsResponseModel.adDetails.required_education}"),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: state.adDetailsResponseModel.adDetails.deadline !=null,
                          child: Column(
                            children: [
                              const SizedBox(height: 5,),
                              state.adDetailsResponseModel.adDetails.deadline !=null ?
                              Text("Deadline: ${DateFormat.yMMMMd().format(DateTime.parse("${state.adDetailsResponseModel.adDetails.deadline}"))}"):
                              Text('Deadline: ${state.adDetailsResponseModel.adDetails.deadline}')
                              ,
                            ],
                          ),
                        ),
                        Visibility(
                          visible: state.adDetailsResponseModel.adDetails.employerName !=null,
                          child: Column(
                            children: [
                              const SizedBox(height: 5,),
                              Text("Employer Name: ${state.adDetailsResponseModel.adDetails.employerName}"),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: state.adDetailsResponseModel.adDetails.propertyType !=null,
                          child: Column(
                            children: [
                              const SizedBox(height: 5,),
                              Text("Property Type: ${state.adDetailsResponseModel.adDetails.propertyType}"),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: state.adDetailsResponseModel.adDetails.propertySize !=null,
                          child: Column(
                            children: [
                              const SizedBox(height: 5,),
                              Text("Property Size: ${state.adDetailsResponseModel.adDetails.propertySize} ${state.adDetailsResponseModel.adDetails.propertyUnit} "),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5,),
                        Visibility(
                          visible: state.adDetailsResponseModel.adDetails.website.isNotEmpty,
                          child: Row(
                            children: [
                              const Text("Website: "),
                              GestureDetector(
                                onTap: () {
                                  urlLaunch(state.adDetailsResponseModel.adDetails.website);
                                },
                                child: const Text("View Site", style: TextStyle(color: Colors.blue),),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            "Description",
                            style: GoogleFonts.lato(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Text(state.adDetailsResponseModel.adDetails.description),
                      ],
                    ),
                  ),
                ),
              ),

              ///SELLER INFORMATION'S SECTION
              SliverPadding(
                padding: const EdgeInsets.all(10),
                sliver: SliverToBoxAdapter(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              offset: const Offset(0, 0),
                              blurRadius: 3),
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Seller Informations",
                              style: GoogleFonts.lato(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.grey.shade300,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CustomImage(
                              // path: RemoteUrls.imageUrl(productModel.image),
                                path: state.adDetailsResponseModel.adDetails.customer?.image != '' ? '${RemoteUrls.rootUrl}${state.adDetailsResponseModel.adDetails.customer?.image}' : null,
                                fit: BoxFit.cover
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            "${state.adDetailsResponseModel.adDetails.customer?.name}",
                            style: GoogleFonts.lato(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RatingBar.builder(
                                initialRating: double.parse("${state.adDetailsResponseModel.adDetails.customer!.averageReview}"),
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
                                "(${double.parse("${state.adDetailsResponseModel.adDetails.customer!.averageReview}").toStringAsFixed(0)}) ",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const Text("Reviews"),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Joined "),
                              Text(DateFormat.yMMMMd().format(DateTime.parse("${state.adDetailsResponseModel.adDetails.customer!.createdAt}")),
                                  style: GoogleFonts.lato(
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Total Listed Ads "),
                              Text("${state.adDetailsResponseModel.adDetails.customer!.totalAds}",
                                  style: GoogleFonts.lato(
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: SizedBox(
                            height: 40,
                            width: 150,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, RouteNames.publicShopScreen,arguments: state.adDetailsResponseModel.adDetails.customer?.username);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF212d6e),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(2))),
                              child: const SizedBox(
                                child: Text(
                                  "Member Shop",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              ///RELATED ADS SECTION
              SliverPadding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                sliver: SliverToBoxAdapter(
                  child: HorizontalProductContainer(
                    adModelList: state.adDetailsResponseModel.relatedAds,
                    title:
                        "Recommended Ads for you",
                    onPressed: () {},
                    from: 'details_page',
                  ),
                ),
              ),

              //.......... Related Ads horizontal ..........
              // SliverToBoxAdapter(
              //   child: Container(
              //     padding: const EdgeInsets.symmetric(vertical: 16),
              //     decoration: BoxDecoration(
              //         color: Colors.white.withAlpha(950),
              //         borderRadius: BorderRadius.circular(16),
              //         boxShadow: const [
              //           BoxShadow(
              //               offset: Offset(5,5),
              //               blurRadius: 3,
              //               color: ashColor,
              //               blurStyle: BlurStyle.inner
              //           )
              //         ]
              //     ),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         const Padding(
              //           padding: EdgeInsets.symmetric(horizontal: 16.0),
              //           child: Text("Related Ads",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w500),),
              //         ),
              //         const SizedBox(
              //           height: 16,
              //         ),
              //         SingleChildScrollView(
              //           scrollDirection: Axis.horizontal,
              //           padding: const EdgeInsets.symmetric(horizontal: 16),
              //           child: Row(
              //             mainAxisSize: MainAxisSize.min,
              //             mainAxisAlignment: MainAxisAlignment.start,
              //             children: [
              //               ConstrainedBox(
              //                 constraints: BoxConstraints(
              //                   // maxHeight: MediaQuery.of(context).size.width * 1.2,
              //                   maxHeight: 430,
              //                   minHeight: MediaQuery.of(context).size.width * 0.8,
              //                 ),
              //                 child: ListView.separated(
              //                   clipBehavior: Clip.none,
              //                   addAutomaticKeepAlives: true,
              //                   shrinkWrap: true,
              //                   // padding: const EdgeInsets.symmetric(horizontal: 16),
              //                   addRepaintBoundaries: true,
              //                   scrollDirection: Axis.horizontal,
              //                   itemBuilder: (context,index){
              //                     // return ListProductCard(productModel: products[index],width: MediaQuery.of(context).size.width * 0.9,);
              //                     return SizedBox();
              //                   },
              //                   itemCount: products.length,
              //                   separatorBuilder: (BuildContext context, int index) {
              //                     return const SizedBox(
              //                       width: 16,
              //                     );
              //                   },
              //                 ),
              //               )
              //             ],
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              // ),

              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 16,
                ),
              )
            ],
          );
        }
        // log(state.toString(), name: _className);
        return const SizedBox();
      }),
    );
  }

  phoneCall(phoneNumber, context) async {
    if (phoneNumber.toString().isNotEmpty) {
      final url = Uri.parse('tel:"$phoneNumber"');
      if (await canLaunchUrl(url)) {
        await launchUrl(
          url,
          webViewConfiguration: const WebViewConfiguration(
            enableJavaScript: true,
            enableDomStorage: true,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('No phone number found')));
    }
  }

  sendEmail(email, context) async {
    if (email.toString().isNotEmpty) {
      final url = Uri.parse('mailto:$email');
      if (await canLaunchUrl(url)) {
        await launchUrl(
          url,
          webViewConfiguration: const WebViewConfiguration(
            enableJavaScript: true,
            enableDomStorage: true,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('No Email has found')));
    }
  }

  Future<void> sendWhatsappMessage(url, context) async {

    print(url);

    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(
            Uri.parse(url),
          webViewConfiguration: const WebViewConfiguration(
            enableJavaScript: true,
            enableDomStorage: true,
          ),
          mode: LaunchMode.externalApplication
        );
      }
    } on Exception {
      print('WhatsApp is not installed');
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No Whatsapp Number has found')));
    }
  }

  ///Launch url
  Future<void> urlLaunch(url) async {
    print(url);
    await launchUrl(
        Uri.parse(url),
        webViewConfiguration: const WebViewConfiguration(
          enableJavaScript: true,
          enableDomStorage: true,
        ),
        mode: LaunchMode.externalApplication
    );
  }

  showReportDialog(context, adId){
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        scrollable: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(child: SizedBox(child: Text("Is there something wrong with this ad?",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),maxLines: 2,overflow: TextOverflow.ellipsis,),),),
            GestureDetector(onTap: () => Navigator.pop(context),child: const Icon(Icons.close))
          ],
        ),
        content: Column(
          children: [
            const Text("We're constantly working hard to assure that our ads meet high standards and we are very grateful for any kind of feedback from our users."),
            const SizedBox(height: 15,),
            const Row(
              children: [
                Text("Reason"),
                Text("*",style: TextStyle(color: Colors.red),),
              ],
            ),
            const SizedBox(height: 3,),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300)
              ),
              child: DropdownButtonFormField(
                validator: (value) {
                  if (value == null) {
                    return null;
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: "Select reason",
                ),
                items: reasonTypeList.map<DropdownMenuItem<String>>((e) {
                  return DropdownMenuItem(
                    value: e['id'],
                    child: Text("${e['name']}"),
                  );
                }).toList(),
                onChanged: (value) {
                  context.read<AdDetailsCubit>().reasonType = value!;
                  setState(() {
                    print(context.read<AdDetailsCubit>().reasonType);
                  });
                },
              ),
            ),
            const SizedBox(height: 10,),
            const Row(
              children: [
                Text("Your Email"),
                Text("*",style: TextStyle(color: Colors.red),),
              ],
            ),
            const SizedBox(height: 3,),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: context.read<AdDetailsCubit>().emailController,
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value == "") {
                  return null;
                }
                return null;
              },
              onChanged: (value) {

              },
              decoration: const InputDecoration(hintText: "your email"),
            ),
            const SizedBox(height: 10,),
            const Row(
              children: [
                Text("Message"),
                Text("*",style: TextStyle(color: Colors.red),),
              ],
            ),
            const SizedBox(height: 3,),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: context.read<AdDetailsCubit>().messageController,
              maxLines: 3,
              validator: (value) {
                if (value == "") {
                  return null;
                }
                return null;
              },
              onChanged: (value) {

              },
              decoration: const InputDecoration(hintText: "your message"),
            ),
            const SizedBox(height: 25,),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 45,
                    child: ElevatedButton(onPressed: () {
                      Navigator.pop(context);
                    },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffdc3545),
                        foregroundColor: Colors.white,
                      ), child: const Text('Close'),
                    ),
                  ),
                ),
                const SizedBox(width: 10,),
                Expanded(
                  child: SizedBox(
                    height: 45,
                    child: ElevatedButton(onPressed: () {
                      context.read<AdDetailsCubit>().postReport(context.read<AdDetailsCubit>().reasonType, context.read<AdDetailsCubit>().emailController.text.trim(), context.read<AdDetailsCubit>().messageController.text.trim(), adId, context).then((value) => Navigator.pop(context));
                    },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: redColor,
                        foregroundColor: Colors.white,
                      ), child: const Text('Submit'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },);
  }

}
