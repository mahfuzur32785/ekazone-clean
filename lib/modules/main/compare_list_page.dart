import 'package:ekayzone/modules/profile/component/compare_list/compare_list_container.dart';
import 'package:ekayzone/modules/profile/controller/compare_list/compare_list_cubit.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/constants.dart';

class CompareListAdsPage extends StatefulWidget {
  const CompareListAdsPage({Key? key}) : super(key: key);

  @override
  State<CompareListAdsPage> createState() => _CompareListAdsPageState();
}

class _CompareListAdsPageState extends State<CompareListAdsPage> {

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() => context.read<CompareListCubit>().getCompareList(true, Hive.box('compareList').values.map((e) => e).toList()));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<CompareListCubit,CompareListState>(
        builder: (context, state) {
          if (state is CompareListStateLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CompareListStateError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: redColor),
              ),
            );
          }
          if(state is CompareListStateLoaded){
            return RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: () => context.read<CompareListCubit>().getCompareList(true, Hive.box('compareList').values.map((e) => e).toList()),
              child: CustomScrollView(
                scrollDirection: Axis.vertical,
                slivers: [
                  const SliverAppBar(
                    title: Text("Compare Ads"),
                  ),
                  CompareListContainer(
                    adModelList: state.adList,
                    onPressed: (){},
                  ),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
