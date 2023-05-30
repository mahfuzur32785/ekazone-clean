part of 'customer_ads_bloc.dart';

abstract class CustomerAdsEvent extends Equatable {
  const CustomerAdsEvent();

  @override
  List<Object> get props => [];
}

class CustomerAdsEventSearch extends CustomerAdsEvent {
  const CustomerAdsEventSearch();

  @override
  List<Object> get props => [];
}

class CustomerAdsEventLoadMore extends CustomerAdsEvent {
  const CustomerAdsEventLoadMore();
}
