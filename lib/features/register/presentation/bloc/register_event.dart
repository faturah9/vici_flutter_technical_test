part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterPageInitEvent extends RegisterEvent {}

class NameChangedEvent extends RegisterEvent {
  final String? name;

  NameChangedEvent(this.name);

  @override
  List<Object> get props => [name!];
}

class UsernameChangedEvent extends RegisterEvent {
  final String? username;

  UsernameChangedEvent(this.username);

  @override
  List<Object> get props => [username!];
}

class PasswordChangedEvent extends RegisterEvent {
  final String? password;

  PasswordChangedEvent(this.password);

  @override
  List<Object> get props => [password!];
}

class NumberPhoneChangedEvent extends RegisterEvent {
  final String? numberPhone;

  NumberPhoneChangedEvent(this.numberPhone);

  @override
  List<Object> get props => [numberPhone!];
}

class ToggleObscureEvent extends RegisterEvent {
  final bool? isObscure;

  ToggleObscureEvent(this.isObscure);

  @override
  List<Object> get props => [isObscure!];
}

class RegisterSubmittedEvent extends RegisterEvent {
  RegisterSubmittedEvent();
}
