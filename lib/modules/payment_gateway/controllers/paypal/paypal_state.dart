part of 'paypal_cubit.dart';

abstract class PaypalState extends Equatable {
  const PaypalState();

  @override
  List<Object> get props => [];
}

class PaypalInitial extends PaypalState {
  const PaypalInitial();
}

class PaypalStateLoading extends PaypalState {
  const PaypalStateLoading();
}

class PaypalStateError extends PaypalState {
  const PaypalStateError(this.message, this.statusCode);

  final String message;
  final int statusCode;

  @override
  List<Object> get props => [message, statusCode];
}

class PaypalStateLoaded extends PaypalState {
  const PaypalStateLoaded(this.checkoutUrl, this.accessToken, this.executeUrl);

  final String checkoutUrl;
  final String accessToken;
  final String executeUrl;

  @override
  List<Object> get props => [checkoutUrl,accessToken,executeUrl];
}
class PaypalStatePaymentSuccessLoaded extends PaypalState {
  const PaypalStatePaymentSuccessLoaded(this.message);

  final String message;
  @override
  List<Object> get props => [message];
}
