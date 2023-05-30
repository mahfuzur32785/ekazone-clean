import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../authentication/controllers/login/login_bloc.dart';
import '../../model/payment_info_model.dart';
import '../payment_repository.dart';
part 'payment_info_state.dart';

class PaymentCubit extends Cubit<PaymentInfoState> {
  final PaymentRepository _paymentRepository;

  final LoginBloc _loginBloc;

  PaymentCubit({
    required LoginBloc loginBloc,
    required PaymentRepository paymentRepository,
  })  : _paymentRepository = paymentRepository,
        _loginBloc = loginBloc,
        super(const PaymentInfoInitial());

  Future<void> getPaymentInfo(Map<String, String> queryParams) async {
    emit(const PaymentInfoLoading());
    // final result = await _paymentRepository.getPaymentInfo(
    //     _loginBloc.userInfo!.accessToken, queryParams);

    // result.fold((failure) {
    //   emit(PaymentInfoError(failure.message, failure.statusCode));
    // }, (data) {
    //   emit(PaymentInfoLoaded(data));
    // });
  }
}
