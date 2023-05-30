part of 'seller_bloc.dart';

abstract class SellerEvent extends Equatable {
  const SellerEvent();

  @override
  List<Object> get props => [];
}

class SellerEventSearch extends SellerEvent {
  const SellerEventSearch();

  @override
  List<Object> get props => [];
}

class SellerEventLoadMore extends SellerEvent {
  const SellerEventLoadMore();
}
