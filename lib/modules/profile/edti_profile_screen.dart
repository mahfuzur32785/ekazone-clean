import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ekayzone/core/router_name.dart';
import 'package:ekayzone/modules/profile/component/edit/change_password.dart';
import 'package:ekayzone/modules/profile/controller/edit_profile/ads_edit_profile_cubit.dart';
import 'package:ekayzone/utils/utils.dart';
import '../../utils/constants.dart';
import 'component/edit/basic_info_edit.dart';
import 'component/edit/delete_account.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<AdEditProfileCubit>().getPublicProfile(''));
  }

  final scrollController = ScrollController();

  void _scrollDown() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account setting"),
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_sharp,color: iconThemeColor,),
        ),
      ),
      body: BlocListener<AdEditProfileCubit,EditProfileState>(
        listenWhen: (previous, current) => previous != current,
        listener: (context, state) {
          if (state is EditProfileStateLoaded) {
            Utils.showSnackBar(context, state.message);
          }
          if (state is EditProfileStateDeleteLoaded) {
            Utils.showSnackBar(context, state.message);
            Navigator.pushNamedAndRemoveUntil(context, RouteNames.authenticationScreen, (route) => false);
          }
          if (state is EditProfileStateError) {
            Utils.errorSnackBar(context, state.errorMsg);
          }
        },
        child: BlocBuilder<AdEditProfileCubit,EditProfileState>(
          buildWhen: ((previous, current) => previous != current),
          builder: (context,state) {
            return CustomScrollView(
              scrollDirection: Axis.vertical,
              controller: scrollController,
              slivers: const [
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                  sliver: SliverToBoxAdapter(
                    child: BasicInfoEdit(),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                  sliver: SliverToBoxAdapter(
                    child: ChangePassEdit(),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                  sliver: SliverToBoxAdapter(
                    child: DeleteAccount(),
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}
