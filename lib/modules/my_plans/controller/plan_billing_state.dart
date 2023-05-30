part of 'plan_billing_cubit.dart';

abstract class PlanBillingState extends Equatable {
  const PlanBillingState();

  @override
  List<Object> get props => [];
}

class PlanBillingStateInitial extends PlanBillingState {
  const PlanBillingStateInitial();
}

class PlanBillingStateLoading extends PlanBillingState {
  const PlanBillingStateLoading();
}

class PlanBillingStateLoaded extends PlanBillingState {
  final List<PlansBillingModel> planList;
  const PlanBillingStateLoaded(this.planList);
  @override
  List<Object> get props => [planList];
}

class PlanBillingStateError extends PlanBillingState {
  final String message;
  final int statusCode;
  const PlanBillingStateError(this.message, this.statusCode);
  @override
  List<Object> get props => [message, statusCode];
}