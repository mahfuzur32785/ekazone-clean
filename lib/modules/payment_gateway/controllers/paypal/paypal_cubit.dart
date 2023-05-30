import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ekayzone/modules/authentication/controllers/login/login_bloc.dart';
import 'package:ekayzone/utils/utils.dart';

import '../../paypal/paypal_service.dart';
import '../payment_repository.dart';

part 'paypal_state.dart';

class PaypalCubit extends Cubit<PaypalState> {
  final PaymentRepository _paymentRepository;

  final LoginBloc _loginBloc;
  PaypalServices paypalServices = PaypalServices();

  PaypalCubit({
    required LoginBloc loginBloc,
    required PaymentRepository paymentRepository,
  })  : _paymentRepository = paymentRepository,
        _loginBloc = loginBloc,
        super(const PaypalInitial());

  Future<void> createPaypalPayment(Map<String, dynamic> body) async {
    emit(const PaypalStateLoading());
    final result = await _paymentRepository.createPaypalPayment(
        paypalServices, body);

    result.fold((failure) {
      emit(PaypalStateError(failure.message, failure.statusCode));
    }, (data) {
      emit(PaypalStateLoaded(data["approvalUrl"]!,data["accessToken"]!,data["executeUrl"]!,));
    });
  }

  Future<void> paymentConfirmation(Map<String, String> body,context) async {
    final token = _loginBloc.userInfo!.accessToken;
    // emit(const PaypalStateLoading());
    Utils.loadingDialog(context);
    final result = await _paymentRepository.paymentConfirmation(
        token, body);
    result.fold((failure) {
      print("TTTTTTTTTTTTTTTTTTTTTT  payment info store fail  TTTTTTTTTTTTTTTTTTTTTTTTTTT");
      Utils.closeDialog(context);
    }, (data) {
      print("TTTTTTTTTTTTTTTTTTTT payment info store success TTTTTTTTTTTTTTTTTTTTTTTTTTTTT");
      Utils.closeDialog(context);
      emit(PaypalStatePaymentSuccessLoaded(data));
    });
  }

}
