part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UsernameChangedEvent extends LoginEvent {
  final String? username;

  UsernameChangedEvent(this.username);


  @override
  List<Object> get props => [username!];
}

class PasswordChangedEvent extends LoginEvent {
  final String? password;

  PasswordChangedEvent(this.password);


  @override
  List<Object> get props => [password!];
}

class ToggleObscureEvent extends LoginEvent {
  final bool? isObscure;

  ToggleObscureEvent(this.isObscure);

  @override
  List<Object> get props => [isObscure!];
}

class LoginSubmittedEvent extends LoginEvent {
  LoginSubmittedEvent();
}

class LoginPageInitEvent extends LoginEvent {}
