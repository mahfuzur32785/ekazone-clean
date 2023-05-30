import 'package:ekayzone/modules/authentication/controllers/login/login_bloc.dart';
import 'package:ekayzone/modules/authentication/models/user_prfile_model.dart';
import 'package:ekayzone/modules/authentication/repository/auth_repository.dart';
import 'package:ekayzone/modules/profile/repository/profile_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../authentication/models/user_login_response_model.dart';
import '../../model/public_profile_model.dart';
import '../../model/social_data_model.dart';
part 'ads_edit_profile_state.dart';

class AdEditProfileCubit extends Cubit<EditProfileState> {
  final AuthRepository authRepository;
  final ProfileRepository profileRepository;
  final LoginBloc loginBloc;

  final formKey = GlobalKey<FormState>();
  final chanePassFormKey = GlobalKey<FormState>();

  AdEditProfileCubit({required this.profileRepository, required this.loginBloc, required this.authRepository})
      : super(const EditProfileStateInitial());

  // ........ Account info ..........
  var nameCtr = TextEditingController();
  var emailCtr = TextEditingController();
  var webSiteCtr = TextEditingController();
  var phoneCtr = TextEditingController();
  var locationCtr = TextEditingController();
  var usernameCtr = TextEditingController();

  var deleteController = TextEditingController();

  bool isError = false;

  var base64Image = '';
  String imageUrl = '';
  String image = '';

  //........ change pass ...........
  var currentPassCtr = TextEditingController();
  var newPassCtr = TextEditingController();
  var confirmPassCtr = TextEditingController();

  Future<void> getPublicProfile(String sortBy) async {
    if (loginBloc.userInfo == null) {
      emit(const EditProfileStateError('Please sign in'));
      return;
    }

    emit(const EditProfileStatePageLoading());

    final username = loginBloc.userInfo!.user.username;

    print("Username: $username");

    final result = await profileRepository.publicProfile(username, sortBy, loginBloc.userInfo?.accessToken??'');

    result.fold(
          (failure) {
        emit(EditProfileStateError(failure.message,));
      },
          (success) {
        final currentState = EditProfileStatePageLoaded(success);
        emit(currentState);
      },
    );
  }

  Future<void> updateAccInfo() async {
    if (!formKey.currentState!.validate()) return;

    emit(const EditProfileStateAccLoading());

    final body = {
      "name": nameCtr.text.trim(),
      "email": emailCtr.text.trim(),
      "phone": phoneCtr.text.trim(),
      "location": locationCtr.text.trim(),
      "website" : locationCtr.text.trim(),
      "username": usernameCtr.text.trim(),
      "image": base64Image,
    };

    print(loginBloc.userInfo!.accessToken);

    final result = await profileRepository.editProfile(body,loginBloc.userInfo!.accessToken);
    result.fold(
          (failure) {
        emit(EditProfileStateError(failure.message));
      },
          (data) {
        // imageUrl = data["data"]["image_url"];
        // image = data["data"]["image"];
        loginBloc.userInfo!.user.copyWith(
          name: nameCtr.text,
          email: emailCtr.text,
          phone: phoneCtr.text,
          username: usernameCtr.text,
          location: locationCtr.text,
          web: webSiteCtr.text,
        );
        // UserLoginResponseModel loginResponseModel = UserLoginResponseModel(user: user,
        //     accessToken: loginBloc.userInfo!.accessToken,
        //     expiresIn: loginBloc.userInfo!.expiresIn,
        //     tokenType: loginBloc.userInfo!.tokenType
        // );

        loginBloc.add(UpdateProfileEvent(getUser()));

        authRepository.saveCashedUserInfo(getUser());

        emit(EditProfileStateLoaded(data["message"]));
      },
    );
  }

  Future<void> changePassword() async {
    if (!chanePassFormKey.currentState!.validate()) return;

    emit(const EditProfileStatePasswordLoading());

    final body = {
      "current_password": currentPassCtr.text.trim(),
      "password": newPassCtr.text.trim(),
      "password_confirmation": confirmPassCtr.text.trim(),
    };

    print("${loginBloc.userInfo!.accessToken} $body");

    final result = await profileRepository.changePassword(body,loginBloc.userInfo!.accessToken);
    result.fold(
          (failure) {
        emit(EditProfileStateError(failure.message));
      },
          (data) {
        currentPassCtr.text = '';
        newPassCtr.text = '';
        confirmPassCtr.text = '';
        emit(EditProfileStateLoaded(data));
      },
    );
  }

  Future<void> deleteAccount(String text) async {
    emit(const EditProfileStateDeleteLoading());

    if (kDebugMode) {
      print(loginBloc.userInfo!.accessToken);
    }
    final result = await profileRepository.deleteAccount('',loginBloc.userInfo!.accessToken, text);
    result.fold(
          (failure) {
        emit(EditProfileStateError(failure.message));
        deleteController.text = '';
          },
          (data) {
        emit(EditProfileStateDeleteLoaded(data));
        deleteController.text = '';
      },
    );
  }

  UserLoginResponseModel getUser() {
    return UserLoginResponseModel(
      user: getUserData(),
      accessToken: loginBloc.userInfo!.accessToken,
      expiresIn: loginBloc.userInfo!.expiresIn,
      tokenType: loginBloc.userInfo!.tokenType,
    );
  }

  UserProfileModel getUserData() {
    return UserProfileModel(
      id: loginBloc.userInfo!.user.id,
      image: image,
      imageUrl: imageUrl,
      email: emailCtr.text,
      location: locationCtr.text,
      web: webSiteCtr.text,
      status: loginBloc.userInfo!.user.status,
      isVendor: loginBloc.userInfo!.user.isVendor,
      emailVerified: loginBloc.userInfo!.user.emailVerified,
      createdAt: loginBloc.userInfo!.user.createdAt,
      updatedAt: loginBloc.userInfo!.user.updatedAt,
      name: nameCtr.text,
      phone: phoneCtr.text,
      showPhone: loginBloc.userInfo!.user.showPhone,
      adCount: loginBloc.userInfo!.user.adCount,
      avgRating: loginBloc.userInfo!.user.avgRating,
      reviewCount: loginBloc.userInfo!.user.reviewCount,
      phoneCode: loginBloc.userInfo!.user.phoneCode,
      iso: loginBloc.userInfo!.user.iso,
      zipCode: loginBloc.userInfo!.user.zipCode,
      address: loginBloc.userInfo!.user.address,
      emailVerifiedAt: loginBloc.userInfo!.user.emailVerifiedAt,
      verifyToken: loginBloc.userInfo!.user.verifyToken,
      username: loginBloc.userInfo!.user.username,
      showEmail: loginBloc.userInfo!.user.showEmail,
      receiveEmail: loginBloc.userInfo!.user.receiveEmail,
    );
  }
}
