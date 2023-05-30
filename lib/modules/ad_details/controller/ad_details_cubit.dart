import 'package:ekayzone/utils/constants.dart';
import 'package:ekayzone/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ekayzone/modules/ad_details/controller/ad_details_state.dart';
import 'package:ekayzone/modules/ad_details/repository/ad_details_repository.dart';
import 'package:ekayzone/modules/authentication/controllers/login/login_bloc.dart';

class AdDetailsCubit extends Cubit<AdDetailsState>{
  AdDetailsCubit(this.adDetailsRepository, this.loginBloc) : super(const AdDetailsStateLoading());
  final AdDetailsRepository adDetailsRepository;
  final LoginBloc loginBloc;

  var emailController = TextEditingController();
  var messageController = TextEditingController();

  String reasonType = '';

  Future<void> getAdDetails(String slug, bool isLoading, String countryCode) async {
    if (isLoading) {
      emit(const AdDetailsStateLoading());
    }

    String token = '';
    if (loginBloc.userInfo != null) {
      token = '${loginBloc.userInfo?.accessToken}';
    }

    final result = await adDetailsRepository.getAdDetails(slug,token,countryCode);
    result.fold((error) => emit(AdDetailsStateError(error.message)), (data) => emit(AdDetailsStateLoaded(data)));
  }

  Future<void> postReport (String reasonId, String email, String message, int adId, context) async {

    Map<String, dynamic> body = {
      "ad_id": adId.toString(),
      "reason": reasonId,
      "email": email,
      "message": message
    };

    String token = '';
    if (loginBloc.userInfo != null) {
      token = '${loginBloc.userInfo?.accessToken}';
    }
    final result = await adDetailsRepository.postReport(body,token);
    print(result);

    result.fold((failure) => Utils.errorSnackBar(context, failure.message), (success) => {
      Utils.showSnackBar(context, success),
      emailController.text = '',
      messageController.text = '',
    });
  }

}