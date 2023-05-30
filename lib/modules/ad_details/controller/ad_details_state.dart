import 'package:equatable/equatable.dart';
import 'package:ekayzone/modules/ad_details/model/details_response_model.dart';

class AdDetailsState extends Equatable{
  const AdDetailsState();
  @override
  List<Object> get props => [];
}

class AdDetailsStateLoading extends AdDetailsState {
  const AdDetailsStateLoading();
}

class AdDetailsStateError extends AdDetailsState {
  final String message;
  const AdDetailsStateError(this.message);
  @override
  List<Object> get props => [message];
}

class AdDetailsStateLoaded extends AdDetailsState {
  final DetailsResponseModel adDetailsResponseModel;
  const AdDetailsStateLoaded(this.adDetailsResponseModel);
  @override
  List<Object> get props => [adDetailsResponseModel];
}