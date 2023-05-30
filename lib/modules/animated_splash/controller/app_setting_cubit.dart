import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ekayzone/modules/home/model/country_model.dart';
import 'package:equatable/equatable.dart';
import 'package:ekayzone/modules/setting/model/setting_model.dart';
import '../repository/app_setting_repository.dart';

part 'app_setting_state.dart';

class AppSettingCubit extends Cubit<AppSettingState> {
  final _className = 'AppSettingCubit';
  final AppSettingRepository _appSettingRepository;
  SettingModel? settingModel;
  List<TopCountry> countryList = [];

  AppSettingCubit(AppSettingRepository appSettingRepository)
      : _appSettingRepository = appSettingRepository,
        super(const AppSettingStateInitial()) {
    init();
    loadWebSetting();
    getCountryData();
  }

  String location = '';
  var defaultLocation;

  bool get isOnBoardingShown =>
      _appSettingRepository.checkOnBoarding().fold((l) => false, (r) => true);

  Future<bool> cacheOnBoarding() async {
    final result = await _appSettingRepository.cacheOnBoarding();

    return result.fold((l) => false, (success) => success);
  }

  void init() {
    emit(const AppSettingStateInitial());
    final localSetting = _appSettingRepository.getCachedWebsiteSetup();

    localSetting.fold(
          (failure) {
        // log(failure.toString(), name: _className);
        emit(const AppSettingStateNotCashed('Not cashed app setting'));
      },
          (value) {
        settingModel = value;
        log('init success', name: _className);
        emit(AppSettingStateLoaded(value));
      },
    );
  }

  Future<void> loadWebSetting() async {
    emit(const AppSettingStateLoading());
    final result = await _appSettingRepository.websiteSetup();
    result.fold(
          (failure) {
        emit(AppSettingStateError(failure.message, failure.statusCode));
      },
          (value) {
        final stateData = AppSettingStateLoaded(value);
        settingModel = value;
        emit(stateData);
      },
    );
  }
  Future<void> getCountryData() async {

    final result = await _appSettingRepository.getCountry();
    result.fold(
          (failure) {
        emit(AppSettingStateError(failure.message, failure.statusCode));
      },
          (value) {
        // final stateData = AppSettingStateLoaded(value);
        countryList = value;

        // defaultLocation = countryList.where((element) => element.isDefault == '1').map((e) => e.iso).toString().replaceAll('(','').replaceAll(')','');
        defaultLocation = countryList.where((element) => element.isDefault == '1').map((e) => e.iso).toString().substring(1,3);

        print("Default Location ${defaultLocation}");
      },
    );
  }
}
