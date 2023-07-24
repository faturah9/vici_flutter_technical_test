part of 'login_bloc.dart';

class LoginState {
  final bool? isUsernameInvalid;
  final bool? isPasswordInvalid;
  final String? username;
  final String? password;
  final bool? isObscure;
  final FormzStatus? submitStatus;
  final String? errorMessage;
  final String? successMessage;
  final UserModel? userModel;

  LoginState({
    this.isUsernameInvalid,
    this.isPasswordInvalid,
    this.username = '',
    this.password = '',
    this.isObscure = true,
    this.submitStatus = FormzStatus.pure,
    this.errorMessage,
    this.successMessage,
    this.userModel,
  });

  LoginState copyWith({
    bool? isUsernameInvalid,
    bool? isPasswordInvalid,
    String? username,
    String? password,
    bool? isObscure,
    FormzStatus? submitStatus,
    String? errorMessage,
    String? successMessage,
    UserModel? userModel,
  }) {
    return LoginState(
      isUsernameInvalid: isUsernameInvalid ?? this.isUsernameInvalid,
      isPasswordInvalid: isPasswordInvalid ?? this.isPasswordInvalid,
      username: username ?? this.username,
      password: password ?? this.password,
      isObscure: isObscure ?? this.isObscure,
      submitStatus: submitStatus ?? this.submitStatus,
      errorMessage: errorMessage,
      successMessage: successMessage,
      userModel: userModel ?? this.userModel,
    );
  }
}

class LoginInitial extends LoginState {}
