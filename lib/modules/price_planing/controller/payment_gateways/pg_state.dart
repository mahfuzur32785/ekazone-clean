part of 'pg_cubit.dart';

abstract class PaymentGatewayState extends Equatable {
  const PaymentGatewayState();

  @override
  List<Object> get props => [];
}

class PaymentGatewayStateInitial extends PaymentGatewayState {
  const PaymentGatewayStateInitial();
}

class PaymentGatewayStateLoading extends PaymentGatewayState {
  const PaymentGatewayStateLoading();
}

class PaymentGatewayStateLoaded extends PaymentGatewayState {
  final PaymentGatewaysResponseModel gatewaysResponseModel;
  const PaymentGatewayStateLoaded(this.gatewaysResponseModel);
  @override
  List<Object> get props => [gatewaysResponseModel];
}

class PaymentGatewayStateError extends PaymentGatewayState {
  final String message;
  final int statusCode;
  const PaymentGatewayStateError(this.message, this.statusCode);
  @override
  List<Object> get props => [message, statusCode];
}