import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:ekayzone/modules/profile/model/public_profile_model.dart';
import 'package:ekayzone/modules/setting/model/user_with_country_response.dart';
import 'package:ekayzone/utils/utils.dart';

import '../../../authentication/controllers/login/login_bloc.dart';
import '../../repository/profile_repository.dart';
part 'public_profile_state.dart';

class PublicProfileCubit extends Cubit<PublicProfileState> {
  PublicProfileCubit({
    required this.profileRepository,
    required LoginBloc loginBloc,
  })  : _loginBloc = loginBloc,
        super(const PublicProfileStateInitial());

  final ProfileRepository profileRepository;
  final LoginBloc _loginBloc;

  bool isMe(id){
    if (id == _loginBloc.userInfo?.user.id) {
      return true;
    }
    return false;
  }

  Future<void> getPublicProfile(username, sortBy) async {
    // if (_loginBloc.userInfo == null) {
    //   emit(const PublicProfileStateError('Please sign in',401));
    //   return;
    // }

    emit(const PublicProfileStateLoading());

    // final username = _loginBloc.userInfo!.user.username;

    final result = await profileRepository.publicProfile(username, sortBy, _loginBloc.userInfo!.accessToken);

    result.fold(
          (failure) {
        emit(PublicProfileStateError(failure.message, failure.statusCode));
      },
          (success) {
        final currentState = PublicProfileStateLoaded(success);
        emit(currentState);
      },
    );
  }

  Future<void> postSellerReview(int rating,String review,seller,context) async {
    if (_loginBloc.userInfo == null) {
      emit(const PublicProfileStateError('Please sign in',401));
      return;
    }

    Utils.loadingDialog(context);

    final token = _loginBloc.userInfo!.accessToken;
    final body = <String, String>{};

    body.addAll({'stars': '$rating'});
    body.addAll({'comment': review.trim()});

    final result = await profileRepository.postSellerReview(body,seller,token);

    result.fold(
          (failure) {
            Utils.closeDialog(context);
            Utils.showSnackBar(context, failure.message);
      },
          (success) {
            Utils.closeDialog(context);
            Utils.showSnackBar(context, success);
      },
    );
  }

}
