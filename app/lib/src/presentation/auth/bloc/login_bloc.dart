import 'package:ai_assessment/src/repositories/auth/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const LoginState()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginPasswordVisibilityToggled>(_onPasswordVisibilityToggled);
    on<LoginSubmitted>(_onSubmitted);
  }

  final AuthRepository _authRepository;

  void _onEmailChanged(
    LoginEmailChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(email: event.email, errorMessage: ''));
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(password: event.password, errorMessage: ''));
  }

  void _onPasswordVisibilityToggled(
    LoginPasswordVisibilityToggled event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (state.email.isEmpty || state.password.isEmpty) {
      emit(
        state.copyWith(
          uiState: LoginUiState.error,
          errorMessage: 'Please enter both email and password',
        ),
      );
      return;
    }

    emit(state.copyWith(uiState: LoginUiState.loading, errorMessage: ''));

    try {
      final response = await _authRepository.login(
        email: state.email,
        password: state.password,
      );
      emit(
        state.copyWith(
          uiState: LoginUiState.loaded,
          loginSuccess: true,
          userName: response.name,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          uiState: LoginUiState.error,
          errorMessage: 'Invalid email or password',
        ),
      );
    }
  }
}
