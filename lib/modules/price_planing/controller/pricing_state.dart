part of 'pricing_cubit.dart';

abstract class PricingState extends Equatable {
  const PricingState();

  @override
  List<Object> get props => [];
}

class PricingStateInitial extends PricingState {
  const PricingStateInitial();
}

class PricingStateLoading extends PricingState {
  const PricingStateLoading();
}

class PricingStateLoaded extends PricingState {
  final List<PricingModel> pricingList;
  const PricingStateLoaded(this.pricingList);
  @override
  List<Object> get props => [pricingList];
}

class PricingStateError extends PricingState {
  final String message;
  final int statusCode;
  const PricingStateError(this.message, this.statusCode);
  @override
  List<Object> get props => [message, statusCode];
}