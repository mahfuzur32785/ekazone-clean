part of 'dashboard_cubit.dart';
abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

class DashboardStateInitial extends DashboardState {
  const DashboardStateInitial();
}

class DashboardStateLoading extends DashboardState {
  const DashboardStateLoading();
}

class DashboardStateLoaded extends DashboardState {
  final DOverViewModel data;
  const DashboardStateLoaded(this.data);
  @override
  List<Object> get props => [data];
}

class DashboardStateError extends DashboardState {
  final String message;
  final int statusCode;
  const DashboardStateError(this.message, this.statusCode);
  @override
  List<Object> get props => [message, statusCode];
}