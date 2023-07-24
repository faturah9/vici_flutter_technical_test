import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:formz/formz.dart';

import '../../../../injection_container.dart';
import '../../../../utils/session_manager.dart';
import '../../../register/domain/datas/models/user_model.dart';
import '../../domain/repository/login_repository.dart';
import '../../domain/repository_impl/login_repository_impl.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository = sl<LoginRepositoryImpl>();
  final AppSharedPreferences _localDataSource = sl<AppSharedPreferencesImpl>();

  LoginBloc() : super(LoginInitial()) {
    on<LoginPageInitEvent>(_mapLoginInitialToState);
    on<UsernameChangedEvent>(_mapUsernameChanged);
    on<PasswordChangedEvent>(_mapPasswordChanged);
    on<ToggleObscureEvent>(_mapToggleObscure);
    on<LoginSubmittedEvent>(_mapLoginSubmitted);
  }

  void _mapLoginInitialToState(
    LoginPageInitEvent event,
    Emitter<LoginState> emit,
  ) {
    final state = this.state;
    return emit(
      state.copyWith(
        submitStatus: FormzStatus.pure,
      ),
    );
  }

  void _mapPasswordChanged(
    PasswordChangedEvent event,
    Emitter<LoginState> emit,
  ) {
    final state = this.state;
    return emit(
      state.copyWith(
        submitStatus: FormzStatus.pure,
        password: event.password,
      ),
    );
  }

  void _mapToggleObscure(
    ToggleObscureEvent event,
    Emitter<LoginState> emit,
  ) {
    final state = this.state;
    return emit(
      state.copyWith(
        submitStatus: FormzStatus.pure,
        isObscure: !state.isObscure!,
      ),
    );
  }

  void _mapUsernameChanged(
    UsernameChangedEvent event,
    Emitter<LoginState> emit,
  ) {
    final state = this.state;
    return emit(
      state.copyWith(
        submitStatus: FormzStatus.pure,
        username: event.username,
      ),
    );
  }

  void _mapLoginSubmitted(
    LoginSubmittedEvent event,
    Emitter<LoginState> emit,
  ) async {
    final state = this.state;
    emit(state.copyWith(submitStatus: FormzStatus.submissionInProgress));

    if (state.username == '' || state.username!.isEmpty) {
      emit(
        state.copyWith(
          errorMessage: 'Username tidak boleh kosong',
          submitStatus: FormzStatus.submissionFailure,
        ),
      );
    } else if (state.password == '' || state.password!.isEmpty) {
      emit(
        state.copyWith(
          errorMessage: 'Password tidak boleh kosong',
          submitStatus: FormzStatus.submissionFailure,
        ),
      );
    }
    try {
      UserModel getUser = await loginRepository.login(
        state.username!,
        state.password!,
      );

      if (getUser.id != null) {
        await sl<AppSharedPreferencesImpl>().setUserId(state.username!);
        _localDataSource.setUser(getUser.username!, getUser);

        emit(
          state.copyWith(
            submitStatus: FormzStatus.submissionSuccess,
            successMessage: 'Login Berhasil',
            userModel: getUser,
          ),
        );
      } else {
        emit(
          state.copyWith(
            submitStatus: FormzStatus.submissionFailure,
            errorMessage: 'Username atau Password salah',
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          submitStatus: FormzStatus.submissionFailure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
