import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'auth_repository.dart';

// Events
abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;
  LoginRequested(this.email, this.password);
  @override
  List<Object?> get props => [email, password];
}

class SignupRequested extends AuthEvent {
  final String email;
  final String password;
  SignupRequested(this.email, this.password);
  @override
  List<Object?> get props => [email, password];
}

class LogoutRequested extends AuthEvent {}

class PasswordResetRequested extends AuthEvent {
  final String email;
  PasswordResetRequested(this.email);
  @override
  List<Object?> get props => [email];
}

// States
abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  final String email;
  Authenticated(this.email);
  @override
  List<Object?> get props => [email];
}

class Unauthenticated extends AuthState {
  final String? message;
  Unauthenticated({this.message});
  @override
  List<Object?> get props => [message];
}

class PasswordResetSent extends AuthState {}

class PasswordResetError extends AuthState {
  final String message;
  PasswordResetError(this.message);
  @override
  List<Object?> get props => [message];
}

// Bloc
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<SignupRequested>(_onSignupRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<PasswordResetRequested>(_onPasswordResetRequested);
  }

  void _onLoginRequested(LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    
    final success = await _authRepository.login(event.email, event.password);
    
    if (success) {
      emit(Authenticated(event.email));
    } else {
      emit(Unauthenticated(message: 'Invalid credentials'));
    }
  }

  void _onSignupRequested(SignupRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    
    final success = await _authRepository.signup(event.email, event.password);
    
    if (success) {
      emit(Authenticated(event.email));
    } else {
      emit(Unauthenticated(message: 'Signup failed'));
    }
  }

  void _onLogoutRequested(LogoutRequested event, Emitter<AuthState> emit) async {
    await _authRepository.signOut();
    emit(AuthInitial());
  }

  void _onPasswordResetRequested(PasswordResetRequested event, Emitter<AuthState> emit) async {
    try {
      final success = await _authRepository.resetPassword(event.email);
      if (success) {
        emit(PasswordResetSent());
      } else {
        emit(PasswordResetError('Failed to send reset email'));
      }
    } catch (e) {
      emit(PasswordResetError('Error: $e'));
    }
  }
}
