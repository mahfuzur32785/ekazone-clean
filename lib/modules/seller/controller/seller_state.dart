part of 'seller_bloc.dart';

abstract class SellerState extends Equatable {
  const SellerState();

  @override
  List<Object> get props => [];
}

class SellerStateInitial extends SellerState {
  const SellerStateInitial();
}

class SellerStateLoading extends SellerState {
  const SellerStateLoading();
}

class SellerStateLoadMore extends SellerState {
  const SellerStateLoadMore();
}

class SellerStateError extends SellerState {
  final String message;
  final int statusCode;

  const SellerStateError(this.message, this.statusCode);
  @override
  List<Object> get props => [message, statusCode];
}

class SellerStateMoreError extends SellerState {
  final String message;
  final int statusCode;

  const SellerStateMoreError(this.message, this.statusCode);
  @override
  List<Object> get props => [message, statusCode];
}

class SellerStateLoaded extends SellerState {
  final List<UserProfileModel> adList;
  const SellerStateLoaded(this.adList);

  @override
  List<Object> get props => [adList];
}

class SellerStateMoreLoaded extends SellerState {
  final List<UserProfileModel> adList;
  const SellerStateMoreLoaded(this.adList);

  @override
  List<Object> get props => [adList];
}
