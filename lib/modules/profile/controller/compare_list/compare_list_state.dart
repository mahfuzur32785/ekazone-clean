part of 'compare_list_cubit.dart';

abstract class CompareListState extends Equatable {
  const CompareListState();

  @override
  List<Object> get props => [];
}

class CompareListStateInitial extends CompareListState {
  const CompareListStateInitial();
}

class CompareListStateLoading extends CompareListState {
  const CompareListStateLoading();
}

class CompareListStateAddRemoving extends CompareListState {
  const CompareListStateAddRemoving();
}

class CompareListStateSuccess extends CompareListState {
  final String message;
  const CompareListStateSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class CompareListStateAddRemoveError extends CompareListState {
  final String message;
  final int statusCode;
  const CompareListStateAddRemoveError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class CompareListStateError extends CompareListState {
  final String message;
  final int statusCode;
  const CompareListStateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class CompareListStateLoaded extends CompareListState {
  final List<AdModel> adList;
  const CompareListStateLoaded(this.adList);

  @override
  List<Object> get props => [adList];
}
