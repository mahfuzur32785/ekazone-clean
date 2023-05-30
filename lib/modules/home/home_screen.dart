import 'dart:core';
import 'dart:core';
import 'dart:core';

import 'package:ekayzone/core/remote_urls.dart';
import 'package:ekayzone/core/router_name.dart';
import 'package:ekayzone/modules/animated_splash/controller/app_setting_cubit.dart';
import 'package:ekayzone/modules/home/component/top_ads_slider.dart';
import 'package:ekayzone/modules/main/main_controller.dart';
import 'package:ekayzone/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ekayzone/modules/home/component/horizontal_ad_container.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/constants.dart';
import '../../utils/k_images.dart';
import '../../widgets/custom_image.dart';
import '../../widgets/custom_textfeild.dart';
import '../ads/controller/adlist_bloc.dart';
import '../category/controller/category_bloc.dart';
import 'component/grid_product_container.dart';
import 'controller/cubit/home_controller_cubit.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scrollController = ScrollController();

  final scrollController2 = ScrollController();

  void toTop() {
    scrollController2.animateTo(0,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  final _className = 'HomeScreen';

  final double height = 114;

  var currentCountryCode;
  var selectedCity;

  String? selected;

  final MainController mainController = MainController();

  late SearchAdsBloc searchAdsBloc;
  late CategoryBloc categoryBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryBloc = context.read<CategoryBloc>();
    context.read<HomeControllerCubit>().updatedCountry.isEmpty ? context.read<HomeControllerCubit>().updatedCountry = context.read<AppSettingCubit>().location : null;
    print("update country code: ${context.read<HomeControllerCubit>().updatedCountry}");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<HomeControllerCubit, HomeControllerState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          // log(state.toString(), name: _className);
          if (state is HomeControllerLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is HomeControllerError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.errorMessage,
                    style: const TextStyle(color: redColor),
                  ),
                  const SizedBox(height: 10),
                  IconButton(
                    onPressed: () {
                      context.read<HomeControllerCubit>().getHomeData(context.read<AppSettingCubit>().location.isEmpty ? context.read<AppSettingCubit>().defaultLocation.toString() :  context.read<AppSettingCubit>().location);
                    },
                    icon: const Icon(Icons.refresh_outlined),
                  ),
                ],
              ),
            );
          }

          if (state is HomeControllerLoaded) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black87,
                // centerTitle: true,
                scrolledUnderElevation: 0,
                title: const CustomImage(
                  path: Kimages.logoColor,
                  height: 50,
                ),
                actions: [
                  SizedBox(
                    height: 55,
                    width: 170,
                    child: PopupMenuButton(
                      icon: Material(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.shade300,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                          child: Text(context.read<HomeControllerCubit>().country),
                        ),
                      ),
                      tooltip: "Select Country",
                      itemBuilder: (context) => <PopupMenuEntry>[
                        ...List.generate(state.homeModel.topCountries.length, (countryIndex) {
                          // print("Length ${state.homeModel.topCountries.length}");
                          return PopupMenuItem(
                            onTap: (){
                              context.read<HomeControllerCubit>().updatedCountry = context.read<AppSettingCubit>().location = state.homeModel.topCountries[countryIndex].iso;
                              print("update country code: ${context.read<HomeControllerCubit>().updatedCountry}");
                              context.read<HomeControllerCubit>().getHomeData(context.read<HomeControllerCubit>().updatedCountry);
                              context.read<HomeControllerCubit>().country = state.homeModel.topCountries[countryIndex].name;
                              context.read<HomeControllerCubit>().symbol = state.homeModel.topCountries[countryIndex].symbol;
                            },
                            child: Text(state.homeModel.topCountries[countryIndex].name),
                          );
                        }),
                      ],
                    ),

                  ),
                ],
              ),
              body: RefreshIndicator(
                key: _refreshIndicatorKey,
                onRefresh: () async {
                  return context.read<HomeControllerCubit>().getHomeData(context.read<HomeControllerCubit>().updatedCountry);
                },
                child: CustomScrollView(
                  controller: scrollController2,
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    /*SliverToBoxAdapter(
                      child: OfferBannerSlider(sliders: sliderList),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        height: height,
                        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          // color: Colors.black54,
                          borderRadius: BorderRadius.circular(4),
                          image: DecorationImage(
                            image: NetworkImage(state.homeModel.banner),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Buy, Sell, And Find Everisamting",style: GoogleFonts.nunitoSans(color: Colors.black87,fontSize: 15,fontWeight: FontWeight.w600),),
                                  Text("Buy, Sell, And Find Everisamting In Vanuatu! Advertise Your Business, Or Service, Find A Job,",
                                    style: GoogleFonts.nunito(color: Colors.black54,fontSize: 12,fontWeight: FontWeight.w400) ,),
                                ],
                              ),
                            ),
                            const Expanded(
                              flex: 1,
                              child: SizedBox(),
                            )
                          ],
                        ),
                      ),
                    ),
                    HomeCategoryContainer(
                      categoryList: state.homeModel.categories,
                      title: "${AppLocalizations.of(context).translate('popular_category')}",
                      onPressed: (){
                        Navigator.pushNamed(context, RouteNames.categorySelection);
                      },
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      sliver: SliverToBoxAdapter(
                        child: HorizontalProductContainer(
                          adModelList: state.homeModel.latestAds,
                          title: "${AppLocalizations.of(context).translate('latest_ads')}",
                          onPressed: (){},
                        ),
                      ),
                    ),*/

                    /// SEARCH, FILTER FILED
                    SliverToBoxAdapter(
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 14, right: 14, top: 14, bottom: 14),
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: const BoxDecoration(
                          color: Color(0XFFF7E7F3),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black12, width: 8),
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            children: [
                              Container(
                                  color: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18),
                                  height: 48,
                                  child: BlocBuilder<CategoryBloc,CategoryState>(
                                    builder: (context,state){
                                      return Material(
                                        color: Colors.white,
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(context, RouteNames.categorySelection);
                                          },
                                          child: Container(
                                              height: 48,
                                              child: Center(
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    SizedBox(child: Text(categoryBloc.getCategoryName(context),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                                                    const Icon(Icons.arrow_drop_down)
                                                  ],
                                                ),
                                              )
                                          ),
                                        ),
                                      );
                                    },
                                  )
                              ),
                              CstmTextFeild(
                                isObsecure: false,
                                controller: context.read<HomeControllerCubit>().searchController,
                                hintext: "What are you looking for?",
                              ),
                              TypeAheadFormField(
                                textFieldConfiguration:
                                TextFieldConfiguration(
                                    // onChanged: (value){
                                    //   print("update country code: ${context.read<HomeControllerCubit>().updatedCountry}");
                                    // },
                                    controller: context.read<HomeControllerCubit>().locationController,
                                    decoration: const InputDecoration(
                                        hintText: 'Location')),
                                suggestionsCallback: (pattern) async {
                                  await getPlaces(pattern, context.read<HomeControllerCubit>().updatedCountry.toString().isEmpty ? context.read<AppSettingCubit>().defaultLocation.toString() : context.read<HomeControllerCubit>().updatedCountry);
                                  return placesSearchResult
                                      .where((element) => element.description!
                                      .toLowerCase()
                                      .contains(pattern
                                      .toString()
                                      .toLowerCase()))
                                      .take(10)
                                      .toList();
                                },
                                itemBuilder: (context, suggestion) {
                                  return ListTile(
                                    title: Text("${suggestion.description}"),
                                  );
                                },
                                transitionBuilder:
                                    (context, suggestionsBox, controller) {
                                  return suggestionsBox;
                                },
                                onSuggestionSelected:
                                    (Prediction suggestion) {
                                      context.read<HomeControllerCubit>().locationController.text = suggestion.description.toString().trim().substring(0, suggestion.description.toString().trim().indexOf(','));
                                      setState(() {
                                        print("Final value ${context.read<HomeControllerCubit>().locationController.text.trim()}");

                                      });
                                },
                                // validator: (value) {
                                //   if (postAdBloc.state.location ==
                                //       '') {
                                //     return 'Enter Your Location';
                                //   } else {
                                //     return null;
                                //   }
                                // },
                                onSaved: (value) {},
                              ),
                              Container(
                                color: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18),
                                height: 48,
                                child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                  hint: const Text('Entire city',
                                      style: TextStyle(color: Colors.black)),
                                  isDense: true,
                                  isExpanded: true,
                                  onChanged: (dynamic value) {
                                    selectedCity = value;
                                    print(selectedCity);
                                    setState(() {

                                    });
                                  },
                                  value: selectedCity,
                                      items: dropDownListData.map((location) {
                                        return DropdownMenuItem<String>(
                                          value: location['value'],
                                          child: Text("${location['title']}"),
                                        );
                                      }).toList(),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 48,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // mainController.naveListener.sink.add(1);
                                    Navigator.pushNamed(context, RouteNames.adsScreen, arguments: [
                                        categoryBloc.categorySlug ?? '', context.read<HomeControllerCubit>().searchController.text ?? '', context.read<HomeControllerCubit>().locationController.text ?? '', selectedCity ?? ''
                                      ],
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.zero),
                                      backgroundColor:
                                          const Color(0xFF212d6e)),
                                  child: const Text("Find it"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    ///SPONSORED AD SECTION
                    SliverToBoxAdapter(
                      child: Visibility(
                        visible: true,
                        child: HorizontalProductContainer(
                          adModelList: state.homeModel.featuredAds,
                          title: "Sponsored ads",
                          onPressed: () {},
                          from: "home",
                        ),
                      ),
                    ),

                    ///TOP ADS SECTION
                    // SliverToBoxAdapter(
                    //   child: Container(
                    //     padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 5),
                    //     child: Column(
                    //       children: [
                    //         Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: const [
                    //             Text(
                    //               'Top Ads',
                    //               style: TextStyle(
                    //                   fontSize: 18,
                    //                   height: 1.5,
                    //                   fontWeight: FontWeight.w600),
                    //             ),
                    //             Text(
                    //               'View all>>',
                    //             )
                    //           ],
                    //         ),
                    //         const SizedBox(
                    //           height: 20,
                    //         ),
                    //         SizedBox(
                    //           height: 100,
                    //           // padding: EdgeInsets.symmetric(vertical: 5),
                    //           width: MediaQuery.of(context).size.width,
                    //           // color: Colors.white,
                    //           child: const TopAdsSlider(),
                    //         ),
                    //         const SizedBox(
                    //           height: 10,
                    //         ),
                    //         SizedBox(
                    //           // padding: EdgeInsets.symmetric(vertical: 5),
                    //           height: 100,
                    //           width: MediaQuery.of(context).size.width,
                    //           // color: Colors.white,
                    //           child: const TopAdsSlider(),
                    //         ),
                    //         // const SizedBox(
                    //         //   height: 10,
                    //         // ),
                    //         // Container(
                    //         //   // margin: EdgeInsets.symmetric(vertical: 10),
                    //         //   padding: const EdgeInsets.all(16),
                    //         //   // height: 100,
                    //         //   decoration: BoxDecoration(
                    //         //       borderRadius: BorderRadius.circular(5),
                    //         //       color: Colors.white,
                    //         //       border:
                    //         //           Border.all(color: Colors.grey.shade300)),
                    //         //   child: const Text(
                    //         //     'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.'),
                    //         // )
                    //       ],
                    //     ),
                    //   ),
                    // ),

                    //const SliverToBoxAdapter(child: SizedBox(height: 20)),

                    ///LATEST AD SECTION

                    const SliverToBoxAdapter(
                      child: SizedBox(height: 15,),
                    ),

                    ///Latest Ad Section
                    GridProductContainer(
                      adModelList: state.homeModel.latestAds,
                      title:
                          "Latest ads",
                      onPressed: () {},
                      from: "home"
                    ),

                    /// list Ads..............
                    // ListProductContainer(
                    //   adModelList: state.homeModel.featuredAds,
                    //   title: "Feature Ads",
                    //   onPressed: (){},
                    // ),

                    const SliverToBoxAdapter(child: SizedBox(height: 30)),

                    /// STATIC ADS IMAGES
                    // SliverToBoxAdapter(
                    //   child: Container(
                    //     padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    //     child: Column(
                    //       children: [
                    //         GestureDetector(onTap: () {
                    //           final url = Uri.parse(RemoteUrls.alikaGuesthouseUrl);
                    //           urlLaunch(url);
                    //         },child: CustomImage(path: 'assets/add1.png',width: MediaQuery.of(context).size.width,)),
                    //         const SizedBox(height: 20,),
                    //         GestureDetector(onTap: () {
                    //           final url = Uri.parse(RemoteUrls.alikaTrainingUrl);
                    //           urlLaunch(url);
                    //         },child: CustomImage(path: 'assets/add2.png',width: MediaQuery.of(context).size.width,))
                    //       ],
                    //     ),
                    //   ),
                    // ),

                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverToBoxAdapter(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color(0xffa5b4fc),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                          child: const Text('eKayzone is a free classified ads community based makertplace Buy and Sale, '
                          'You should be 18 and above to advertise on eKayzone. '
                              'Be careful of scamers, never send money, and always meet in public places',textAlign: TextAlign.center,),
                        ),
                      )
                    ),


                    ///DONATE SECTION
                    SliverPadding(
                      padding: const EdgeInsets.all(16),
                      sliver: SliverToBoxAdapter(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey.shade300)
                          ),
                          child: Column(
                            children: [
                              const Text("Donate Us",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14)),
                              const SizedBox(height: 10,),
                              const Text("Donation Ekayzone community marketplace Donate to help sustainability",textAlign: TextAlign.center,style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                              const SizedBox(height: 20,),
                              GestureDetector(onTap: () {
                                final url = Uri.parse(RemoteUrls.donateUrl);
                                urlLaunch(url);
                              },child: const CustomImage(path: 'assets/donate.gif',)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    
                    ///Browse ads by country
                    SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverToBoxAdapter(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.grey.shade300)
                          ),
                          child: Column(
                            children: [
                              const Text("Browse ads by country",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14)),
                              const SizedBox(height: 10,),
                              GestureDetector(
                                onTap: () {
                                final url = Uri.parse(RemoteUrls.donateUrl);
                                urlLaunch(url);
                              },
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  children: [
                                    ...List.generate(state.homeModel.topCountries.length, (index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: GestureDetector(
                                          onTap: (){
                                            context.read<HomeControllerCubit>().updatedCountry = context.read<AppSettingCubit>().location = state.homeModel.topCountries[index].iso;
                                            print("update country code: ${context.read<HomeControllerCubit>().updatedCountry}");
                                            context.read<HomeControllerCubit>().getHomeData(context.read<HomeControllerCubit>().updatedCountry);
                                            context.read<HomeControllerCubit>().country = state.homeModel.topCountries[index].name;
                                            context.read<HomeControllerCubit>().symbol = state.homeModel.topCountries[index].symbol;
                                          },
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              CustomImage(path: "${RemoteUrls.rootUrl}${state.homeModel.topCountries[index].flag}", height: 20,width: 30,),
                                              const SizedBox(
                                                width: 0,
                                              ),
                                              Text(state.homeModel.topCountries[index].name)
                                            ],
                                          ),
                                        ),
                                      );
                                    })
                                  ],
                                ),

                              ),
                            ],
                          ),
                        ),
                      ),
                    )

                  ],
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  ///Launch url
  Future<void> urlLaunch(url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        webViewConfiguration: const WebViewConfiguration(
          enableJavaScript: true,
          enableDomStorage: true,
        ),
        mode: LaunchMode.externalApplication
      );
    }
  }

  ///......... Location search ................
  List<Prediction> placesSearchResult = [];
  static const kGoogleApiKey = "AIzaSyCGYnCh2Uusd7iASDhsUCxvbFgkSifkkTM";
  // static const kGoogleApiKey = "AIzaSyA72zy8Wy4kFpom_brg28OqBOa8S0eXXGY";
  final places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
  late PlacesSearchResponse response;
  Future<List<Prediction>> getPlaces(text, countryCode) async {
    await places.autocomplete(text, types: ['locality'],components: [Component(Component.country, countryCode.toString())], radius: 1000).then((value) {
      print("Values are ${value.status}");
      placesSearchResult = value.predictions;
      print("${value.predictions.length}");
      if (value.predictions.isNotEmpty) {
        print(value.predictions.map((e) => e.description!.log()));
        placesSearchResult = value.predictions;
      }
    });

    return placesSearchResult;
  }

}
