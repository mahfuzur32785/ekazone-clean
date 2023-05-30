import 'package:ekayzone/modules/profile/component/compare_list/compare_list_container.dart';
import 'package:ekayzone/modules/profile/controller/compare_list/compare_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../utils/constants.dart';

class CompareListAdScreen extends StatefulWidget {
  const CompareListAdScreen({Key? key}) : super(key: key);

  @override
  State<CompareListAdScreen> createState() => _CompareListAdScreenState();
}

class _CompareListAdScreenState extends State<CompareListAdScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() => context.read<CompareListCubit>().getCompareList(true, Hive.box('compareList').values.map((e) => e).toList()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FE),
      appBar: AppBar(
        title: const Text("Compare List"),
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_sharp,color: iconThemeColor,),
        ),
      ),
      body: BlocBuilder<CompareListCubit,CompareListState>(
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
            return CustomScrollView(
              scrollDirection: Axis.vertical,
              slivers: [
                CompareListContainer(
                  adModelList: state.adList,
                  onPressed: (){},
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
