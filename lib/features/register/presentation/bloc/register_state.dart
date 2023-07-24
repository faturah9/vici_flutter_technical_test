part of 'register_bloc.dart';

class RegisterState {
  final FormzStatus? submitStatus;
  final String? name;
  final String? username;
  final String? password;
  final String? numberPhone;
  final bool? isObscure;
  final String? errorMessage;
  final String? successMessage;

  RegisterState({
    this.submitStatus = FormzStatus.pure,
    this.name = '',
    this.username = '',
    this.password = '',
    this.numberPhone = '',
    this.isObscure = true,
    this.errorMessage,
    this.successMessage,
  });

  RegisterState copyWith({
    FormzStatus? submitStatus,
    String? name,
    String? username,
    String? password,
    String? numberPhone,
    bool? isObscure,
    String? errorMessage,
    String? successMessage,
  }) {
    return RegisterState(
      submitStatus: submitStatus ?? this.submitStatus,
      name: name ?? this.name,
      username: username ?? this.username,
      password: password ?? this.password,
      numberPhone: numberPhone ?? this.numberPhone,
      isObscure: isObscure ?? this.isObscure,
      errorMessage: errorMessage,
      successMessage: successMessage,
    );
  }
}

class RegisterInitial extends RegisterState {}
