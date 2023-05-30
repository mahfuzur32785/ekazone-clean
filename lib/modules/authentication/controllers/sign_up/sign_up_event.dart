part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

// class SignUpEventName extends SignUpEvent {
//   final String name;
//
//   const SignUpEventName(this.name);
//   @override
//   List<Object> get props => [name];
// }

class SignUpEventEmail extends SignUpEvent {
  final String email;

  const SignUpEventEmail(this.email);
  @override
  List<Object> get props => [email];
}

// class SignUpEventUserName extends SignUpEvent {
//   final String username;
//
//   const SignUpEventUserName(this.username);
//   @override
//   List<Object> get props => [username];
// }

class SignUpEventPassword extends SignUpEvent {
  final String password;

  const SignUpEventPassword(this.password);
  @override
  List<Object> get props => [password];
}

class SignUpEventPasswordConfirm extends SignUpEvent {
  final String passwordConfirm;

  const SignUpEventPasswordConfirm(this.passwordConfirm);
  @override
  List<Object> get props => [passwordConfirm];
}

// class SignUpEventAgree extends SignUpEvent {
//   final int agree;
//
//   const SignUpEventAgree(this.agree);
//   @override
//   List<Object> get props => [agree];
// }

class SignUpEventSubmit extends SignUpEvent {}
