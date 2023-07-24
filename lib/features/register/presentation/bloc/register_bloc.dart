import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';
import 'package:vici_technical_test/features/register/domain/datas/models/user_model.dart';

import '../../../../injection_container.dart';
import '../../domain/repository/register_repository.dart';
import '../../domain/repository_impl/register_repository_impl.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterRepository registerRepository = sl<RegisterRepositoryImpl>();

  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterPageInitEvent>(_mapRegisterInitialToState);
    on<NameChangedEvent>(_mapNameChanged);
    on<UsernameChangedEvent>(_mapUsernameChanged);
    on<PasswordChangedEvent>(_mapPasswordChanged);
    on<NumberPhoneChangedEvent>(_mapNumberPhoneChanged);
    on<ToggleObscureEvent>(_mapToggleObscure);
    on<RegisterSubmittedEvent>(_mapRegisterSubmitted);
  }

  void _mapRegisterInitialToState(
    RegisterPageInitEvent event,
    Emitter<RegisterState> emit,
  ) {
    final state = this.state;
    return emit(
      state.copyWith(
        submitStatus: FormzStatus.pure,
      ),
    );
  }

  void _mapNameChanged(
    NameChangedEvent event,
    Emitter<RegisterState> emit,
  ) {
    final state = this.state;
    return emit(
      state.copyWith(
        submitStatus: FormzStatus.pure,
        name: event.name,
      ),
    );
  }

  void _mapUsernameChanged(
    UsernameChangedEvent event,
    Emitter<RegisterState> emit,
  ) {
    final state = this.state;
    return emit(
      state.copyWith(
        submitStatus: FormzStatus.pure,
        username: event.username,
      ),
    );
  }

  void _mapPasswordChanged(
    PasswordChangedEvent event,
    Emitter<RegisterState> emit,
  ) {
    final state = this.state;
    return emit(
      state.copyWith(
        submitStatus: FormzStatus.pure,
        password: event.password,
      ),
    );
  }

  void _mapNumberPhoneChanged(
    NumberPhoneChangedEvent event,
    Emitter<RegisterState> emit,
  ) {
    final state = this.state;
    return emit(
      state.copyWith(
        submitStatus: FormzStatus.pure,
        numberPhone: event.numberPhone,
      ),
    );
  }

  void _mapToggleObscure(
    ToggleObscureEvent event,
    Emitter<RegisterState> emit,
  ) {
    final state = this.state;
    return emit(
      state.copyWith(
        submitStatus: FormzStatus.pure,
        isObscure: !state.isObscure!,
      ),
    );
  }

  Future<void> _mapRegisterSubmitted(
    RegisterSubmittedEvent event,
    Emitter<RegisterState> emit,
  ) async {
    final state = this.state;

    emit(state.copyWith(submitStatus: FormzStatus.submissionInProgress));
    if (state.name!.isEmpty || state.name == "") {
      return emit(
        state.copyWith(
          submitStatus: FormzStatus.submissionFailure,
          errorMessage: 'Nama Lengkap tidak boleh kosong',
        ),
      );
    } else if (state.username!.isEmpty || state.username == "") {
      return emit(
        state.copyWith(
          submitStatus: FormzStatus.submissionFailure,
          errorMessage: 'Username tidak boleh kosong',
        ),
      );
    } else if (state.password!.isEmpty || state.password == "") {
      return emit(
        state.copyWith(
          submitStatus: FormzStatus.submissionFailure,
          errorMessage: 'Password tidak boleh kosong',
        ),
      );
    } else if (state.numberPhone!.isEmpty || state.numberPhone == "") {
      return emit(
        state.copyWith(
          submitStatus: FormzStatus.submissionFailure,
          errorMessage: 'Nomor Telepon tidak boleh kosong',
        ),
      );
    }
    try {
      ///insert to db UserModel

      UserModel getUserModel =
          await registerRepository.getUserData(state.username!);

      if (getUserModel.id != null) {
        return emit(
          state.copyWith(
            submitStatus: FormzStatus.submissionFailure,
            errorMessage: 'Username sudah terdaftar',
          ),
        );
      } else {
        UserModel registUserModel = await registerRepository.sendRegisterData(
          state.name!,
          state.username!,
          state.password!,
          state.numberPhone!,
        );
        if (registUserModel.id != null) {
          emit(
            state.copyWith(
              submitStatus: FormzStatus.submissionSuccess,
              successMessage: 'Berhasil mendaftar',
            ),
          );
        }
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
