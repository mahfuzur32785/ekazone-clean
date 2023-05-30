part of 'ads_edit_profile_cubit.dart';
class EditProfileState extends Equatable {
  const EditProfileState();

  @override
  List<Object> get props => [];
}

class EditProfileStateInitial extends EditProfileState {
  const EditProfileStateInitial();
}

class EditProfileStatePageLoading extends EditProfileState {
  const EditProfileStatePageLoading();
}

class EditProfileStatePageLoaded extends EditProfileState {
  final PublicProfileModel data;
  const EditProfileStatePageLoaded(this.data);
  @override
  List<Object> get props => [data];
}

class EditProfileStateAccLoading extends EditProfileState {
  const EditProfileStateAccLoading();
}

class EditProfileStateError extends EditProfileState {
  const EditProfileStateError(this.errorMsg);
  final String errorMsg;
  @override
  List<Object> get props => [errorMsg];
}

class EditProfileStateLoaded extends EditProfileState {
  const EditProfileStateLoaded(this.message);
  final String message;
  @override
  List<Object> get props => [message];
}


class EditProfileStateSocialLoading extends EditProfileState {
  const EditProfileStateSocialLoading();
}


class EditProfileStatePasswordLoading extends EditProfileState {
  const EditProfileStatePasswordLoading();
}


class EditProfileStateDeleteLoading extends EditProfileState {
  const EditProfileStateDeleteLoading();
}

class EditProfileStateDeleteLoaded extends EditProfileState {
  const EditProfileStateDeleteLoaded(this.message);
  final String message;
  @override
  List<Object> get props => [message];
}