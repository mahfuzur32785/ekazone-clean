part of 'public_profile_cubit.dart';
abstract class PublicProfileState extends Equatable {
  const PublicProfileState();

  @override
  List<Object> get props => [];
}

class PublicProfileStateInitial extends PublicProfileState {
  const PublicProfileStateInitial();
}

class PublicProfileStateLoading extends PublicProfileState {
  const PublicProfileStateLoading();
}

class PublicProfileStateLoaded extends PublicProfileState {
  final PublicProfileModel data;
  const PublicProfileStateLoaded(this.data);
  @override
  List<Object> get props => [data];
}

class PublicProfileStateError extends PublicProfileState {
  final String message;
  final int statusCode;
  const PublicProfileStateError(this.message, this.statusCode);
  @override
  List<Object> get props => [message, statusCode];
}