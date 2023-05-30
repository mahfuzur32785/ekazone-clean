part of 'customer_ads_bloc.dart';

abstract class CustomerAdsState extends Equatable {
  const CustomerAdsState();

  @override
  List<Object> get props => [];
}

class CustomerAdsStateInitial extends CustomerAdsState {
  const CustomerAdsStateInitial();
}

class CustomerAdsStateLoading extends CustomerAdsState {
  const CustomerAdsStateLoading();
}

class CustomerAdsStateLoadMore extends CustomerAdsState {
  const CustomerAdsStateLoadMore();
}

class CustomerAdsStateError extends CustomerAdsState {
  final String message;
  final int statusCode;

  const CustomerAdsStateError(this.message, this.statusCode);
  @override
  List<Object> get props => [message, statusCode];
}

class CustomerAdsStateMoreError extends CustomerAdsState {
  final String message;
  final int statusCode;

  const CustomerAdsStateMoreError(this.message, this.statusCode);
  @override
  List<Object> get props => [message, statusCode];
}

class CustomerAdsStateLoaded extends CustomerAdsState {
  final List<AdDetails> adList;
  const CustomerAdsStateLoaded(this.adList);

  @override
  List<Object> get props => [adList];
}

class CustomerAdsStateMoreLoaded extends CustomerAdsState {
  final List<AdDetails> adList;
  const CustomerAdsStateMoreLoaded(this.adList);

  @override
  List<Object> get props => [adList];
}
