import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/set_password_model.dart';
import '../../repository/auth_repository.dart';
part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final AuthRepository repository;

  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final codeController = TextEditingController();
  final passwordController = TextEditingController();
  // final passwordConfirmController = TextEditingController();

  ForgotPasswordCubit(this.repository)
      : super(const ForgotPasswordStateInitial());

  Future<void> forgotPassWord() async {
    if (!formKey1.currentState!.validate()) return;

    emit(const ForgotPasswordStateLoading());

    final body = {"email": emailController.text.trim()};

    final result = await repository.sendForgotPassCode(body);

    print(result);

    result.fold(
      (failure) {
        emit(ForgotPasswordStateError(failure.message));
      },
      (data) {
        emit(ForgotPasswordStateLoaded(data));
      },
    );
  }

  Future<void> setNewPassword() async {
    if (!formKey2.currentState!.validate()) return;

    emit(const ForgotPasswordStateLoading());

    // final model = SetPasswordModel(
    //   code: codeController.text.trim(),
    //   email: emailController.text.trim(),
    //   password: passwordController.text.trim(),
    //   // passwordConfirmation: passwordController.text,
    // );

    final body = {"email": emailController.text.trim(),"token": codeController.text.trim(), "password": passwordController.text.trim()};

    print(body);

    final result = await repository.setPassword(body);
    result.fold(
      (failure) {
        emit(ForgotPasswordStateError(failure.message));
      },
      (data) {
        emit(PasswordSetStateLoaded(data));
      },
    );
  }
}
