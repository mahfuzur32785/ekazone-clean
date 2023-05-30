part of 'payment_info_cubit.dart';

abstract class PaymentInfoState extends Equatable {
  const PaymentInfoState();

  @override
  List<Object> get props => [];
}

class PaymentInfoInitial extends PaymentInfoState {
  const PaymentInfoInitial();
}

class PaymentInfoLoading extends PaymentInfoState {
  const PaymentInfoLoading();
}

class PaymentInfoError extends PaymentInfoState {
  final String message;
  final int statusCode;

  const PaymentInfoError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class PaymentInfoLoaded extends PaymentInfoState {
  final PaymentInfoModel paymentInfoModel;
  const PaymentInfoLoaded(this.paymentInfoModel);

  @override
  List<Object> get props => [paymentInfoModel];
}
