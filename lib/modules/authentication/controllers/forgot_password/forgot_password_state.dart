part of 'forgot_password_cubit.dart';

abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();

  @override
  List<Object> get props => [];
}

class ForgotPasswordStateInitial extends ForgotPasswordState {
  const ForgotPasswordStateInitial();
}

class ForgotPasswordStateLoading extends ForgotPasswordState {
  const ForgotPasswordStateLoading();
}

class ForgotPasswordStateError extends ForgotPasswordState {
  const ForgotPasswordStateError(this.errorMsg);

  final String errorMsg;

  @override
  List<Object> get props => [errorMsg];
}

class ForgotPasswordStateLoaded extends ForgotPasswordState {
  const ForgotPasswordStateLoaded(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

class PasswordStateError extends ForgotPasswordState {
  const PasswordStateError(this.errorMsg);

  final String errorMsg;

  @override
  List<Object> get props => [errorMsg];
}

class PasswordSetStateLoaded extends ForgotPasswordState {
  const PasswordSetStateLoaded(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
