import 'package:bloc/bloc.dart';
import 'package:ekayzone/modules/authentication/controllers/login/login_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../model/home_model.dart';
import '../repository/home_repository.dart';

part 'home_controller_state.dart';

class HomeControllerCubit extends Cubit<HomeControllerState> {
  HomeControllerCubit(HomeRepository homeRepository, LoginBloc loginBloc)
      : _homeRepository = homeRepository,
        _loginBloc = loginBloc,

      super(HomeControllerLoading()) {
    // getHomeData(jhkdfajiasdkhfjkasdf);
  }

  final HomeRepository _homeRepository;
  late HomeModel homeModel;
  final LoginBloc _loginBloc;

  String country = 'Select Country';
  String symbol = 'BDT';
  String updatedCountry = '';

  TextEditingController searchController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  String token = '';

  // getUpdateCountry(String country){
  //   emit(HomeControllerLoading());
  //   Future.delayed(const Duration(milliseconds: 100)).then((value){
  //     this.country = country;
  //     emit(HomeControllerLoaded(homeModel: homeModel));
  //   });
  // }

  Future<void> getHomeData(countryCode) async {
    emit(HomeControllerLoading());

    if (_loginBloc.userInfo != null) {
      token = '${_loginBloc.userInfo?.accessToken}';
    }

    final result = await _homeRepository.getHomeData(countryCode, token);
    result.fold(
      (failure) {
        emit(HomeControllerError(errorMessage: failure.message));
      },
      (data) {
        homeModel = data;
        // country = data.topCountries.isEmpty ? 'Canada' : data.topCountries[0].nicename;
        emit(HomeControllerLoaded(homeModel: data));
      },
    );
  }

  Future<void> getHomeDataOnRefresh(countryCode) async {
    // emit(HomeControllerLoading());

    if (_loginBloc.userInfo != null) {
      token = '${_loginBloc.userInfo?.accessToken}';
    }

    final result = await _homeRepository.getHomeData(countryCode, token);
    result.fold(
          (failure) {
        emit(HomeControllerError(errorMessage: failure.message));
      },
          (data) {
        homeModel = data;
        emit(HomeControllerLoaded(homeModel: data));
      },
    );
  }
}
