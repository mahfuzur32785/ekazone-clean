import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ekayzone/modules/dashboard/model/overview_model.dart';
import 'package:ekayzone/modules/price_planing/controller/pricing_repository.dart';

import '../../../authentication/controllers/login/login_bloc.dart';
import '../../model/payment_gateways_response_model.dart';

part 'pg_state.dart';

class PaymentGatewayCubit extends Cubit<PaymentGatewayState> {
  PaymentGatewayCubit({
    required PricingRepository pricingRepository,
    required LoginBloc loginBloc,
  })  : _pricingRepository = pricingRepository,
        _loginBloc = loginBloc,
        super(const PaymentGatewayStateInitial());

  final PricingRepository _pricingRepository;
  final LoginBloc _loginBloc;

  Future<void> getPaymentGateways() async {
    if (_loginBloc.userInfo == null) {
      emit(const PaymentGatewayStateError('Please sign in',401));
      return;
    }

    emit(const PaymentGatewayStateLoading());

    final token = _loginBloc.userInfo!.accessToken;

    final result = await _pricingRepository.paymentGateways(token);

    result.fold(
          (failure) {
        emit(PaymentGatewayStateError(failure.message, failure.statusCode));
      },
          (success) {
        final currentState = PaymentGatewayStateLoaded(success);
        emit(currentState);
      },
    );
  }
}
