import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';

import '../../../../core/error/failure.dart';
import '../../repository/auth_repository.dart';
part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpModelState> {
  final AuthRepository repository;
  final formKey = GlobalKey<FormState>();
  SignUpBloc(this.repository) : super(const SignUpModelState()) {
    // on<SignUpEventName>((event, emit) {
    //   emit(state.copyWith(name: event.name));
    // });
    on<SignUpEventEmail>((event, emit) {
      emit(state.copyWith(email: event.email));
    });
    // on<SignUpEventUserName>((event, emit) {
    //   emit(state.copyWith(username: event.username));
    // });
    on<SignUpEventPassword>((event, emit) {
      emit(state.copyWith(password: event.password));
    });
    on<SignUpEventPasswordConfirm>((event, emit) {
      emit(state.copyWith(passwordConfirmation: event.passwordConfirm));
    });
    // on<SignUpEventAgree>((event, emit) {
    //   emit(state.copyWith(agree: event.agree));
    // });
    on<SignUpEventSubmit>(_submitForm);
  }
  void _submitForm(
      SignUpEventSubmit event, Emitter<SignUpModelState> emit) async {
    if (!formKey.currentState!.validate()) return;

    if (state.agree == 0) {
      const stateError =
          SignUpStateFormError('Please agree with privacy policy');
      emit(state.copyWith(state: const SignUpStateInitial()));
      emit(state.copyWith(state: stateError));
      return;
    }
    emit(state.copyWith(state: const SignUpStateLoading()));
    final bodyData = state.toMap();

    final result = await repository.signUp(bodyData);

    result.fold(
      (Failure failure) {
        final error = SignUpStateLoadedError(failure.message);
        emit(state.copyWith(state: error));
      },
      (user) {
        emit(state.copyWith(state: SignUpStateLoaded(user)));
      },
    );
  }
}
