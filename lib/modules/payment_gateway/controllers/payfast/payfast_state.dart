part of 'payfast_cubit.dart';

abstract class PayfastState extends Equatable {
  const PayfastState();

  @override
  List<Object> get props => [];
}

class PayfastStateInitial extends PayfastState {
  const PayfastStateInitial();
}

class PayfastStateLoading extends PayfastState {
  const PayfastStateLoading();
}

class PayfastStateError extends PayfastState {
  const PayfastStateError(this.message, this.statusCode);

  final String message;
  final int statusCode;

  @override
  List<Object> get props => [message, statusCode];
}

class PayfastStateLoaded extends PayfastState {
  const PayfastStateLoaded(this.message);

  final dynamic message;

  @override
  List<Object> get props => [message];
}