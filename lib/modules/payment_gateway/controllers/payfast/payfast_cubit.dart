import 'package:ekayzone/modules/authentication/controllers/login/login_bloc.dart';
import 'package:ekayzone/modules/payment_gateway/controllers/payment_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'payfast_state.dart';

class PayfastCubit extends Cubit<PayfastState>{
  final PaymentRepository _paymentRepository;

  final LoginBloc _loginBloc;

  // PayfastServices payfastServices = PayfastServices();

  PayfastCubit({
    required LoginBloc loginBloc,
    required PaymentRepository paymentRepository,
  })  : _paymentRepository = paymentRepository,
        _loginBloc = loginBloc,
        super(const PayfastStateInitial());

  Future<void> createPayfastPayment(Map<String, dynamic> body, String? token) async {

    emit(const PayfastStateLoading());
    final result = await _paymentRepository.createPayfastPayment(body, token!);

    result.fold((failure) {
      print("Return fail $failure");
      emit(PayfastStateError(failure.message, failure.statusCode));
    }, (data) {
      print("Return suc $data");
      emit(PayfastStateLoaded(data));
    },
    );
  }
  
}