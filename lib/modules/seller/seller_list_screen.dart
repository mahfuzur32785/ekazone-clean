import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ekayzone/modules/ads/controller/adlist_bloc.dart';
import 'package:ekayzone/modules/ads/controller/customer_ads/customer_ads_bloc.dart';
import 'package:ekayzone/modules/home/component/grid_product_container2.dart';
import 'package:ekayzone/modules/seller/component/seller_grid_container.dart';
import 'package:ekayzone/modules/seller/controller/seller_bloc.dart';

import '../../utils/constants.dart';
import '../../utils/utils.dart';

class SellerListScreen extends StatefulWidget {
  const SellerListScreen({Key? key}) : super(key: key);

  @override
  State<SellerListScreen> createState() => _SellerListScreenState();
}

class _SellerListScreenState extends State<SellerListScreen> {
  final _scrollController = ScrollController();

  late SellerBloc sellerBloc;

  @override
  void initState() {
    super.initState();
    sellerBloc = context.read<SellerBloc>();
    Future.microtask(() => context.read<SellerBloc>().add(const SellerEventSearch()));
    _init();
  }

  void _init() {
    _scrollController.addListener(() {
      final maxExtent = _scrollController.position.maxScrollExtent - 200;
      if (maxExtent < _scrollController.position.pixels) {
        sellerBloc.add(const SellerEventLoadMore());
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    sellerBloc.sellers.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sellers'),
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
          SliverToBoxAdapter(
              child: BlocConsumer<SellerBloc, SellerState>(
                listenWhen: (previous, current) => previous != current,
                listener: (context, state) {
                  if (state is SellerStateMoreError) {
                    Utils.errorSnackBar(context, state.message);
                  }
                },
                builder: (context, state) {
                  final sellers = sellerBloc.getSellers;
                  if (sellerBloc.sellers.isEmpty && state is SellerStateLoading) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.width * 1.2,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (state is SellerStateError) {
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
                  return Column(
                    children: [
                      SellerGridContainer(
                        sellers: sellers,
                      ),
                      Visibility(
                        visible: state is SellerStateMoreError,
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
