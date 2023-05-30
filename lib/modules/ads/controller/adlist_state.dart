part of 'adlist_bloc.dart';
abstract class SearchAdsState extends Equatable {
  const SearchAdsState();

  @override
  List<Object> get props => [];
}

class SearchAdsStateInitial extends SearchAdsState {
  const SearchAdsStateInitial();
}

class SearchAdsStateLoading extends SearchAdsState {
  const SearchAdsStateLoading();
}

class SearchAdsStateLoadMore extends SearchAdsState {
  const SearchAdsStateLoadMore();
}

class SearchAdsStateError extends SearchAdsState {
  final String message;
  final int statusCode;

  const SearchAdsStateError(this.message, this.statusCode);
  @override
  List<Object> get props => [message, statusCode];
}

class SearchAdsStateMoreError extends SearchAdsState {
  final String message;
  final int statusCode;

  const SearchAdsStateMoreError(this.message, this.statusCode);
  @override
  List<Object> get props => [message, statusCode];
}

class SearchAdsStateLoaded extends SearchAdsState {
  final List<AdModel> adList;
  const SearchAdsStateLoaded(this.adList);

  @override
  List<Object> get props => [adList];
}

class SearchAdsStateMoreLoaded extends SearchAdsState {
  final List<AdModel> adList;
  const SearchAdsStateMoreLoaded(this.adList);

  @override
  List<Object> get props => [adList];
}
