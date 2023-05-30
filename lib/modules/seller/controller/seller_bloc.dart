import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ekayzone/modules/authentication/models/user_prfile_model.dart';
import 'package:ekayzone/modules/seller/controller/seller_repository.dart';
import 'package:ekayzone/modules/seller/model/seller_response_model.dart';

import 'package:stream_transform/stream_transform.dart';

import '../../../../core/remote_urls.dart';
import '../../../../utils/constants.dart';
part 'seller_event.dart';
part 'seller_state.dart';
class SellerBloc extends Bloc<SellerEvent,SellerState> {
  final SellerRepository _sellerRepository;
  SellerBloc({
    required SellerRepository sellerRepository,
  })
      : _sellerRepository = sellerRepository,
        super(const SellerStateInitial()){
    // on<SellerEventSearch>(_seller,);
    on<SellerEventLoadMore>( _loadMore);
  }

  List<UserProfileModel> sellers = [];
  SellerResponseModel? sellerResponseModel;

  List<UserProfileModel> get getSellers => sellers.where((element) => element.adCount! > 0).toList();

  void _loadMore(SellerEventLoadMore event, Emitter<SellerState> emit) async {
    print("xxxxxxxxxxxxxx load modre xxxxxxxxxxxxxx");
    if (state is SellerStateLoadMore) return;
    if (sellerResponseModel == null ||
        sellerResponseModel?.nextPageUrl == null) {
      return;
    }

    emit(const SellerStateLoadMore());

    final uri = Uri.parse(sellerResponseModel!.nextPageUrl!);

    final result = await _sellerRepository.sellers(uri,);

    result.fold(
          (failure) {
        emit(SellerStateMoreError(failure.message, failure.statusCode));
      },
          (successData) {
            sellerResponseModel = successData;
        sellers.addAll(successData.seller);

        emit(SellerStateMoreLoaded(sellers.toSet().toList()));
      },
    );
  }
}

EventTransformer<Event> debounce<Event>() {
  return (events, mapper) => events.debounce(kDuration).switchMap(mapper);
}
