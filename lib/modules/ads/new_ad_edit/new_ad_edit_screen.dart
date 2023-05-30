import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../ad_details/model/ad_details_model.dart';
import '../../authentication/controllers/login/login_bloc.dart';
import 'component/new_basic_info.dart';
import 'controller/new_ad_edit_bloc.dart';

class NewAdEditScreen extends StatefulWidget {
  const NewAdEditScreen({Key? key, required this.adModel}) : super(key: key);
  final AdDetails adModel;
  @override
  State<NewAdEditScreen> createState() => _NewAdEditScreenState();
}

class _NewAdEditScreenState extends State<NewAdEditScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() {
      context.read<NewEditAdBloc>().add(const NewEditAdEventEmpty());
      context
          .read<NewEditAdBloc>()
          .add(NewEditAdEventLoadOldData(widget.adModel));
    });
  }

  @override
  Widget build(BuildContext context) {
    final postAdBloc = context.read<NewEditAdBloc>();
    final loginBloc = context.read<LoginBloc>();
    return BlocListener<NewEditAdBloc, NewEditAdModalState>(
      listenWhen: (previous, current) => previous.state != current.state,
      listener: (context, state) {
        if (state.state is NewEditAdStateError) {
          Utils.closeDialog(context);
          final status = state.state as NewEditAdStateError;
          Utils.errorSnackBar(context, status.errorMsg);
        }
        if (state.state is NewEditAdStateLoading) {
          Utils.loadingDialog(context);
        }
        if (state.state is NewEditAdStateLoaded) {
          Utils.closeDialog(context);
          final status = state.state as NewEditAdStateLoaded;
          if (status.isBack) {
            Utils.showSnackBar(context, status.message);
            Future.delayed(const Duration(seconds: 1)).then((value) {
              Navigator.of(
                context,
              ).pop(true);
            });
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Edit post",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: redColor,
          iconTheme: const IconThemeData(color: Colors.white),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_outlined,
              color: Colors.white,
            ),
          ),
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: redColor,
              statusBarIconBrightness: Brightness.light),
        ),
        body: NewEditBasicInfoView(adModel: widget.adModel),
        bottomNavigationBar: Container(
          height: 70,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 6,
                    offset: const Offset(0, -5))
              ]),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: ElevatedButton(
            onPressed: () {
              if (postAdBloc.featureFormKey.currentState!.validate()) {
                Utils.closeKeyBoard(context);
                postAdBloc.add(NewEditAdEventSubmit(
                    loginBloc.userInfo!.accessToken, widget.adModel.id));
                // if (postAdBloc.state.images.isEmpty) {
                //   Utils.errorSnackBar(context, "You must upload 1 image");
                // } else {
                //   // Utils.loadingDialog(context);
                //   postAdBloc.add(NewPostAdEventSubmit(loginBloc.userInfo!.accessToken));
                // }
              }
            },
            child: const Text("Update"),
          ),
        ),
      ),
    );
  }
}
