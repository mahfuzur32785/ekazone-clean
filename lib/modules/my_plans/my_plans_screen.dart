import 'package:ekayzone/modules/my_plans/component/my_plan_card.dart';
import 'package:ekayzone/modules/my_plans/controller/plan_billing_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../utils/constants.dart';

class MyPlansScreen extends StatefulWidget {
  const MyPlansScreen({Key? key}) : super(key: key);

  @override
  State<MyPlansScreen> createState() => _MyPlansScreenState();
}

class _MyPlansScreenState extends State<MyPlansScreen> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<PlanBillingCubit>().getPlanBillingList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transactions"),
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_sharp,color: iconThemeColor,),
        ),
      ),
      body: BlocBuilder<PlanBillingCubit,PlanBillingState>(
          builder: (context,state) {
            if (state is PlanBillingStateLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is PlanBillingStateError) {
              return Center(
                child: Text(state.message),
              );
            }
            if (state is PlanBillingStateLoaded) {
              return CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return MyPlanCard(plansBillingModel: state.planList[index],index: index,);
                      },childCount: state.planList.length),
                    ),
                  )
                ],
              );
            }
            return const SizedBox();
          }
      ),
    );
  }

}
