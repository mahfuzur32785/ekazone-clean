import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ekayzone/modules/dashboard/model/overview_model.dart';
import 'package:ekayzone/modules/price_planing/controller/pricing_repository.dart';

import '../../authentication/controllers/login/login_bloc.dart';
import '../../profile/repository/profile_repository.dart';
import '../model/plans_billing_model.dart';

part 'plan_billing_state.dart';

class PlanBillingCubit extends Cubit<PlanBillingState> {
  PlanBillingCubit({
    required PricingRepository pricingRepository,
    required LoginBloc loginBloc,
  })  : _pricingRepository = pricingRepository,
        _loginBloc = loginBloc,
        super(const PlanBillingStateInitial());

  final PricingRepository _pricingRepository;
  final LoginBloc _loginBloc;

  Future<void> getPlanBillingList() async {
    if (_loginBloc.userInfo == null) {
      emit(const PlanBillingStateError('Please sign in',401));
      return;
    }

    emit(const PlanBillingStateLoading());

    final token = _loginBloc.userInfo!.accessToken;

    final result = await _pricingRepository.getMyPlanBillingList(token);

    result.fold(
          (failure) {
        emit(PlanBillingStateError(failure.message, failure.statusCode));
      },
          (success) {
        final currentState = PlanBillingStateLoaded(success);
        emit(currentState);
      },
    );
  }
}
