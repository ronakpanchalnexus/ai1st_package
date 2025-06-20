import 'package:ai1st_package/src/features/authentication/domain/entity/forgot_password_entity.dart';
import 'package:ai1st_package/src/features/authentication/domain/entity/sign_in_entity.dart';
import 'package:ai1st_package/src/features/authentication/domain/usecases/forgot_password_use_case.dart';
import 'package:ai1st_package/src/features/authentication/domain/usecases/sign_in_use_case.dart';
import 'package:ai1st_package/src/shared/data_state.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required SignInUseCase signInUseCase,
    required ForgotPasswordUseCase forgotPasswordUseCase,
  })  : _signInUseCase = signInUseCase,
        _forgotPasswordUseCase = forgotPasswordUseCase,
        super(const TogglePasswordState(false)) {
    on<SignInEvent>(_onSignIn);
    on<TogglePasswordEvent>(_onTogglePassword);
    on<ForgotPasswordEvent>(_onForgotPassword);
  }

  final SignInUseCase _signInUseCase;
  final ForgotPasswordUseCase _forgotPasswordUseCase;

  Future<void> _onSignIn(
    SignInEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoading());

    final result = await _signInUseCase.call(event.signInParams);

    if (result is DataSuccess && result.data != null) {
      emit(SignedInStateSuccess(result.data!));
    }

    if (result is DataFailed) {
      emit(SignedInStateFailed(result.error!));
    }
  }

  Future<void> _onForgotPassword(
    ForgotPasswordEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoading());

    final result = await _forgotPasswordUseCase.call(event.email);

    if (result is DataSuccess && result.data != null) {
      emit(ForgotPasswordStateSuccess(result.data!));
    }

    if (result is DataFailed) {
      emit(ForgotPasswordStateFailed(result.error!));
    }
  }

  Future<void> _onTogglePassword(
    TogglePasswordEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    final current = state is TogglePasswordState
        ? (state as TogglePasswordState).togglePassword
        : false;
    emit(TogglePasswordState(!current));
  }
}
