import 'package:ai_assessment/l10n/l10n.dart';
import 'package:ai_assessment/src/core/configs/routes/route_name.dart';
import 'package:ai_assessment/src/presentation/auth/bloc/login_bloc.dart';
import 'package:ai_assessment/src/repositories/auth/auth_repository.dart';
import 'package:ai_assessment/src/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key, this.loginBloc});

  final LoginBloc? loginBloc;

  @override
  Widget build(BuildContext context) {
    final bloc =
        loginBloc ??
        LoginBloc(authRepository: IAuthRepository(authService: IAuthService()));

    return BlocProvider.value(value: bloc, child: const _LoginView());
  }
}

class _LoginView extends StatelessWidget {
  const _LoginView();

  static const _primaryText = Color(0xFF121417);
  static const _secondaryText = Color(0xFF61758A);
  static const _buttonBlue = Color(0xFF268CF5);
  static const _borderColor = Color(0xFFDBE0E5);
  static const _fontFamily = 'Plus Jakarta Sans';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.loginSuccess) {
            context.pushNamed(Routes.feedbackRoute);
          }
        },
        builder: (context, state) {
          final l10n = context.l10n;
          return SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // App Logo
                        _buildAppLogo(l10n),

                        // Email field
                        _buildEmailField(context, state, l10n),

                        // Password field
                        _buildPasswordField(context, state, l10n),

                        // Forgot Password
                        _buildForgotPassword(l10n),

                        // Error message
                        if (state.errorMessage.isNotEmpty)
                          _buildErrorMessage(state.errorMessage),

                        // Sign In button
                        _buildSignInButton(context, state, l10n),
                      ],
                    ),
                  ),
                ),

                // Bottom section
                _buildBottomSection(l10n),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAppLogo(AppLocalizations l10n) {
    return Container(
      height: 60,
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
      alignment: Alignment.center,
      child: Text(
        l10n.loginLogo,
        style: const TextStyle(
          fontFamily: _fontFamily,
          fontWeight: FontWeight.w700,
          fontSize: 22,
          height: 1.27,
          color: _primaryText,
        ),
      ),
    );
  }

  Widget _buildEmailField(
    BuildContext context,
    LoginState state,
    AppLocalizations l10n,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              l10n.loginEmailLabel,
              style: const TextStyle(
                fontFamily: _fontFamily,
                fontWeight: FontWeight.w500,
                fontSize: 16,
                height: 1.5,
                color: _primaryText,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _borderColor),
            ),
            child: TextField(
              onChanged: (value) {
                context.read<LoginBloc>().add(LoginEmailChanged(email: value));
              },
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(
                fontFamily: _fontFamily,
                fontWeight: FontWeight.w400,
                fontSize: 16,
                height: 1.5,
                color: _primaryText,
              ),
              decoration: InputDecoration(
                hintText: l10n.loginEmailHint,
                hintStyle: const TextStyle(
                  fontFamily: _fontFamily,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  height: 1.5,
                  color: _secondaryText,
                ),
                contentPadding: const EdgeInsets.all(15),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField(
    BuildContext context,
    LoginState state,
    AppLocalizations l10n,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              l10n.loginPasswordLabel,
              style: const TextStyle(
                fontFamily: _fontFamily,
                fontWeight: FontWeight.w500,
                fontSize: 16,
                height: 1.5,
                color: _primaryText,
              ),
            ),
          ),
          Container(
            height: 56,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                // Text input area
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                      border: Border(
                        top: BorderSide(color: _borderColor),
                        left: BorderSide(color: _borderColor),
                        bottom: BorderSide(color: _borderColor),
                      ),
                    ),
                    child: TextField(
                      onChanged: (value) {
                        context.read<LoginBloc>().add(
                          LoginPasswordChanged(password: value),
                        );
                      },
                      obscureText: state.obscurePassword,
                      style: const TextStyle(
                        fontFamily: _fontFamily,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        height: 1.5,
                        color: _primaryText,
                      ),
                      decoration: InputDecoration(
                        hintText: l10n.loginPasswordHint,
                        hintStyle: const TextStyle(
                          fontFamily: _fontFamily,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          height: 1.5,
                          color: _secondaryText,
                        ),
                        contentPadding: const EdgeInsets.fromLTRB(
                          15,
                          15,
                          8,
                          15,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                // Eye icon toggle
                GestureDetector(
                  onTap: () {
                    context.read<LoginBloc>().add(
                      const LoginPasswordVisibilityToggled(),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.only(right: 15),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                      border: Border(
                        top: BorderSide(color: _borderColor),
                        right: BorderSide(color: _borderColor),
                        bottom: BorderSide(color: _borderColor),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: Icon(
                        state.obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 24,
                        color: _secondaryText,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForgotPassword(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
      child: Align(
        child: Text(
          l10n.loginForgotPassword,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: _fontFamily,
            fontWeight: FontWeight.w400,
            fontSize: 14,
            height: 1.5,
            color: _secondaryText,
          ),
        ),
      ),
    );
  }

  Widget _buildErrorMessage(String message) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontFamily: _fontFamily,
          fontWeight: FontWeight.w400,
          fontSize: 14,
          height: 1.5,
          color: Colors.red,
        ),
      ),
    );
  }

  Widget _buildSignInButton(
    BuildContext context,
    LoginState state,
    AppLocalizations l10n,
  ) {
    final isLoading = state.uiState == LoginUiState.loading;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: SizedBox(
        height: 48,
        child: ElevatedButton(
          onPressed: isLoading
              ? null
              : () {
                  context.read<LoginBloc>().add(const LoginSubmitted());
                },
          style: ElevatedButton.styleFrom(
            backgroundColor: _buttonBlue,
            disabledBackgroundColor: _buttonBlue.withValues(alpha: 0.6),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            elevation: 0,
          ),
          child: isLoading
              ? const SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: Colors.white,
                  ),
                )
              : Text(
                  l10n.loginSignIn,
                  style: const TextStyle(
                    fontFamily: _fontFamily,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    height: 1.5,
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildBottomSection(AppLocalizations l10n) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
          child: Align(
            child: Text(
              l10n.loginSignUpPrompt,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: _fontFamily,
                fontWeight: FontWeight.w400,
                fontSize: 14,
                height: 1.5,
                color: _secondaryText,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
