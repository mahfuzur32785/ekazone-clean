import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ekayzone/modules/ads/model/adlist_response_model.dart';
import 'package:ekayzone/modules/home/model/ad_model.dart';

import '../../../core/remote_urls.dart';
import '../../../utils/constants.dart';
import '../../category/controller/category_bloc.dart';
import '../repository/adlist_repository.dart';
import 'package:stream_transform/stream_transform.dart';
part 'adlist_event.dart';
part 'adlist_state.dart';
class SearchAdsBloc extends Bloc<SearchAdsEvent,SearchAdsState> {
  final SearchAdsRepository _searchAdsRepository;
  // final CategoryBloc _categoryBloc;
  SearchAdsBloc({
    required SearchAdsRepository searchAdsRepository,
    // required CategoryBloc categoryBloc
  })
      : _searchAdsRepository = searchAdsRepository,
        // _categoryBloc = categoryBloc,
        super(const SearchAdsStateInitial()){
    // on<SearchAdsEventSearch>(_searchAds, transformer: debounce());
    on<SearchAdsEventSearch>(_searchAds,);
    on<SearchAdsEventLoadMore>( _loadMore);
  }

  List<AdModel> adList = [];
  AdListResponseModel? adListResponseModel;

  RangeValues rangeValues = const RangeValues(0,20000);
  List<String> sortingList = ['latest','oldest'];
  String sortingText = 'latest';
  List<String> filteredList = ['featured','popular'];
  String filteredText = 'popular';

  void _searchAds(SearchAdsEventSearch event, Emitter<SearchAdsState> emit) async {
    print("............. Search Ads .............");
    adList = [];
    emit(const SearchAdsStateLoading());
    final uri = Uri.parse(RemoteUrls.searchAds).replace(
      queryParameters: {
        'search': event.search,
        'price_min': event.priceMin,
        'price_max': event.priceMax,
        'paginate': '10',
        'location': event.locationSearchValue,
        'km': event.distanceValue,
        'sort_by': event.shortBy,
        'category': event.category,
        'country_code': event.countryCode
        // 'subcategory': event.subCategory,
      },
    );
    print("Filtering url is: $uri");

    final result = await _searchAdsRepository.searchAds(uri);

    result.fold((failure) {
      emit(SearchAdsStateError(failure.message, failure.statusCode));
    }, (successData) {
      adListResponseModel = successData;

      adList = successData.adList;

      emit(SearchAdsStateLoaded(successData.adList));
    });
  }

  void _loadMore(SearchAdsEventLoadMore event, Emitter<SearchAdsState> emit) async {
    if (state is SearchAdsStateLoadMore) return;
    if (adListResponseModel == null ||
        adListResponseModel?.nextPageUrl == null) {
      return;
    }

    emit(const SearchAdsStateLoadMore());

    final uri = Uri.parse(adListResponseModel!.nextPageUrl!);

    final result = await _searchAdsRepository.searchAds(uri);

    result.fold(
          (failure) {
        emit(SearchAdsStateMoreError(failure.message, failure.statusCode));
      },
          (successData) {
        adListResponseModel = successData;
        adList.addAll(successData.adList);

        emit(SearchAdsStateMoreLoaded(adList.toSet().toList()));
      },
    );
  }
}

EventTransformer<Event> debounce<Event>() {
  return (events, mapper) => events.debounce(kDuration).switchMap(mapper);
}
