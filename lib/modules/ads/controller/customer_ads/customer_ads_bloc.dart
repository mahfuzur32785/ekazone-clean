import 'package:dartz/dartz.dart';
import 'package:ekayzone/modules/home/controller/cubit/home_controller_cubit.dart';
import 'package:ekayzone/modules/home/controller/repository/home_repository.dart';
import 'package:ekayzone/modules/home/model/pricing_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ekayzone/modules/ad_details/model/ad_details_model.dart';
import 'package:ekayzone/modules/ads/model/adlist_response_model.dart';
import 'package:ekayzone/modules/ads/model/customer_adlist_response_model.dart';
import 'package:ekayzone/modules/authentication/controllers/login/login_bloc.dart';
import 'package:ekayzone/modules/home/model/ad_model.dart';

import 'package:stream_transform/stream_transform.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/remote_urls.dart';
import '../../../../utils/constants.dart';
import '../../repository/adlist_repository.dart';
part 'customer_ads_event.dart';
part 'customer_ads_state.dart';
class CustomerAdsBloc extends Bloc<CustomerAdsEvent,CustomerAdsState> {
  final SearchAdsRepository _searchAdsRepository;
  final HomeControllerCubit _homeControllerCubit;
  final LoginBloc _loginBloc;
  CustomerAdsBloc({
    required SearchAdsRepository searchAdsRepository,
    required LoginBloc loginBloc,
    required HomeControllerCubit homeControllerCubit
  })
      : _searchAdsRepository = searchAdsRepository,
        _loginBloc = loginBloc,
        _homeControllerCubit = homeControllerCubit,
        super(const CustomerAdsStateInitial()){
    // on<CustomerAdsEventSearch>(_searchAds, transformer: debounce());
    on<CustomerAdsEventSearch>(_searchAds,);
    on<CustomerAdsEventLoadMore>( _loadMore);
  }

  List<AdDetails> adList = [];
  CustomerAdListResponseModel? adListResponseModel;

  List<PricingModel> get pricingList => _homeControllerCubit.homeModel.plans.toList();
  String price = '';
  int id = 0;
  String title = '';


  void _searchAds(CustomerAdsEventSearch event, Emitter<CustomerAdsState> emit) async {
    adList = [];
    emit(const CustomerAdsStateLoading());
    final uri = Uri.parse(RemoteUrls.customerAds).replace(
      queryParameters: {
        'paginate': '10',
        'filter_by': '',
        'sort_by': '',
      }
    );

    if (kDebugMode) {
      print(uri);
    }

    final result = await _searchAdsRepository.customerAds(uri,_loginBloc.userInfo!.accessToken);

    result.fold((failure) {
      emit(CustomerAdsStateError(failure.message, failure.statusCode));
    }, (successData) {
      adListResponseModel = successData;

      adList = successData.adList;

      emit(CustomerAdsStateLoaded(successData.adList));
    });
  }

  void _loadMore(CustomerAdsEventLoadMore event, Emitter<CustomerAdsState> emit) async {
    if (state is CustomerAdsStateLoadMore) return;
    if (adListResponseModel == null ||
        adListResponseModel?.nextPageUrl == null) {
      return;
    }

    emit(const CustomerAdsStateLoadMore());

    final uri = Uri.parse(adListResponseModel!.nextPageUrl!);

    final result = await _searchAdsRepository.customerAds(uri,_loginBloc.userInfo!.accessToken);

    result.fold(
          (failure) {
        emit(CustomerAdsStateMoreError(failure.message, failure.statusCode));
      },
          (successData) {
        adListResponseModel = successData;
        adList.addAll(successData.adList);

        emit(CustomerAdsStateMoreLoaded(adList.toSet().toList()));
      },
    );
  }

  Future<Either<Failure, String>> deleteMyAd(int id) async {
    if (_loginBloc.userInfo == null) {
      return const Left(ServerFailure("Please Login first", 401));
    }
    final token = _loginBloc.userInfo!.accessToken;
    final result = await _searchAdsRepository.deleteMyAd(id,token);

    return result;
  }

}

EventTransformer<Event> debounce<Event>() {
  return (events, mapper) => events.debounce(kDuration).switchMap(mapper);
}
