import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ekayzone/dummy_data/all_dudmmy_data.dart';
import 'package:ekayzone/modules/dashboard/component/chart_component.dart';
import 'package:ekayzone/modules/dashboard/component/top_bar.dart';
import 'package:ekayzone/modules/dashboard/controller/dashboard_cubit.dart';
import 'package:ekayzone/modules/home/component/list_product_card.dart';
import 'package:ekayzone/modules/home/component/product_card.dart';
import 'package:ekayzone/utils/constants.dart';
import 'package:ekayzone/utils/utils.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../home/component/horizontal_ad_container.dart';
import 'component/grid_card_container.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<DashboardCubit>().getDashboardData());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F3F6),
      // backgroundColor: Colors.red,
      body: SafeArea(
        child: BlocBuilder<DashboardCubit,DashboardState>(
            builder: (context,state) {
              if (state is DashboardStateLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is DashboardStateError) {
                return Center(
                  child: Text(state.message),
                );
              }
              if (state is DashboardStateLoaded) {
                return CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      sliver: SliverToBoxAdapter(child: DashboardTopBar(overViewModel: state.data,)),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                      sliver: DashboardGridCardLayout(overViewModel: state.data),
                    ),

                    // SliverToBoxAdapter(
                    //   child: ColumnChart(overViewModel: state.data),
                    // ),
                    //
                    // SliverPadding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                    //   sliver: SliverToBoxAdapter(
                    //     child: Visibility(
                    //       visible: state.data.activities.isNotEmpty,
                    //       child: Container(
                    //         padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                    //         decoration: BoxDecoration(
                    //             color: Colors.white.withAlpha(950),
                    //             borderRadius: BorderRadius.circular(16),
                    //             boxShadow: const [
                    //               BoxShadow(
                    //                   offset: Offset(5,5),
                    //                   blurRadius: 3,
                    //                   color: ashColor,
                    //                   blurStyle: BlurStyle.inner
                    //               )
                    //             ]
                    //         ),
                    //         child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Text("${AppLocalizations.of(context).translate('recent_activities')}",style: const TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w500),),
                    //             const SizedBox(
                    //               height: 16,
                    //             ),
                    //             ...List.generate(state.data.activities.length, (index) {
                    //               return Padding(
                    //                 padding: const EdgeInsets.symmetric(vertical: 5.0),
                    //                 child: Row(
                    //                   children: [
                    //                     Container(
                    //                       margin: const EdgeInsets.symmetric(vertical: 8),
                    //                       decoration: BoxDecoration(
                    //                           borderRadius: BorderRadius.circular(6),
                    //                           color: Colors.green.withOpacity(0.2)
                    //                       ),
                    //                       padding: const EdgeInsets.all(10),
                    //                       child: const Icon(Icons.check,color: Colors.green,size: 30,),
                    //                     ),
                    //                     const SizedBox(
                    //                       width: 16,
                    //                     ),
                    //                     Expanded(
                    //                       child: Column(
                    //                         mainAxisSize: MainAxisSize.min,
                    //                         crossAxisAlignment: CrossAxisAlignment.start,
                    //                         children: [
                    //                           SizedBox(child: Text(state.data.activities[index].data.msg)),
                    //                           Text(Utils.formatDate(DateTime.parse(state.data.activities[index].createdAt)),textAlign: TextAlign.start,
                    //                           style: TextStyle(color: Colors.black45,fontSize: 13),),
                    //                         ],
                    //                       ),
                    //                     )
                    //                   ],
                    //                 ),
                    //               );
                    //             })
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),

                    ///.......... Recent Ads horizontal ..........
                    SliverToBoxAdapter(
                      child: HorizontalProductContainer(
                        adModelList: state.data.recentAds.adList,
                        title: "Recent ads",
                        onPressed: (){},
                        from: 'Dashboard',
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 30,
                      ),
                    ),
                  ],
                );
              }
              return const SizedBox();
          }
        ),
      ),
    );
  }

}