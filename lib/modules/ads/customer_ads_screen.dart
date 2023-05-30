import 'package:ekayzone/modules/ads/component/customer_ad_card_list.dart';
import 'package:ekayzone/modules/ads/controller/customer_ads/customer_ads_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';

class CustomerAdsScreen extends StatefulWidget {
  const CustomerAdsScreen({Key? key}) : super(key: key);

  @override
  State<CustomerAdsScreen> createState() => _CustomerAdsScreenState();
}

class _CustomerAdsScreenState extends State<CustomerAdsScreen> {
  final _scrollController = ScrollController();

  late CustomerAdsBloc customerAdsBloc;

  @override
  void initState() {
    super.initState();
    customerAdsBloc = context.read<CustomerAdsBloc>();
    Future.microtask(() => context.read<CustomerAdsBloc>().add(const CustomerAdsEventSearch()));
    _init();
  }

  void _init() {
    _scrollController.addListener(() {
      final maxExtent = _scrollController.position.maxScrollExtent - 100;
      if (maxExtent < _scrollController.position.pixels) {
        customerAdsBloc.add(const CustomerAdsEventLoadMore());
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    customerAdsBloc.adList.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ashColor,
      appBar: AppBar(
        title: Text('My ads'),
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_sharp,color: iconThemeColor,),
        ),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        scrollDirection: Axis.vertical,
        slivers: [
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 8,
            ),
          ),
          SliverToBoxAdapter(
              child: BlocConsumer<CustomerAdsBloc, CustomerAdsState>(
                listener: (context, state) {
                  if (state is CustomerAdsStateMoreError) {
                    Utils.errorSnackBar(context, state.message);
                  }
                },
                builder: (context, state) {
                  final adList = customerAdsBloc.adList;
                  if (state is CustomerAdsStateLoading) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.width * 1.2,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  else if (state is CustomerAdsStateError) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.width * 1.2,
                      child: Center(
                        child: Text(
                          state.message,
                          style: const TextStyle(color: redColor),
                        ),
                      ),
                    );
                  }
                  if(customerAdsBloc.adList.isEmpty){
                    return SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: Center(
                        child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: Colors.black54)
                            ),
                            child: Text("Ads Not Found",style: const TextStyle(color: Colors.black54,fontSize: 16,fontWeight: FontWeight.w500),)),
                      ),
                    );

                  }
                  return Column(
                    children: [
                      /// ....... Grid View Ads ...............
                      // GridView.builder(
                      //   padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                      //   shrinkWrap: true,
                      //   physics: const NeverScrollableScrollPhysics(),
                      //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      //     crossAxisCount: 2,
                      //     crossAxisSpacing: 8,
                      //     mainAxisSpacing: 8,
                      //     mainAxisExtent: 300,
                      //   ),
                      //   itemBuilder: (context,index){
                      //     return CustomerAdCard(adModel: adList[index]);
                      //   },
                      //   itemCount: adList.length,
                      // ),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return CustomerAdListCard(adModel: adList[index], deleteAd: (){
                            setState(() {
                              adList.removeAt(index);
                            });
                          },);
                        },
                        itemCount: adList.length,
                      ),
                      Visibility(
                        visible: state is CustomerAdsStateLoadMore,
                        child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: const Center(
                              child: SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator()),
                            )),
                      ),
                    ],
                  );
                },
              )
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 50,
            ),
          )
        ],
      ),
    );
  }
}
