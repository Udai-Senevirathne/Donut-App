import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

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

// Bloc
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // Simulated in-memory user database (only for demo)
  final Map<String, String> _userDatabase = {
    'test@test.com': 'password',
  };

  AuthBloc() : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<SignupRequested>(_onSignupRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  void _onLoginRequested(LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await Future.delayed(const Duration(seconds: 1));

    final email = event.email.trim().toLowerCase();
    final password = event.password.trim();

    print('Trying to log in with: $email / $password');

    if (_userDatabase.containsKey(email) && _userDatabase[email] == password) {
      emit(Authenticated(email));
    } else {
      emit(Unauthenticated(message: 'Invalid credentials'));
    }
  }

  void _onSignupRequested(SignupRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await Future.delayed(const Duration(seconds: 1));

    final email = event.email.trim().toLowerCase();
    final password = event.password.trim();

    // Simulate saving user to "database"
    _userDatabase[email] = password;

    print('New user signed up: $email / $password');

    // Auto-login after signup
    emit(Authenticated(email));
  }

  void _onLogoutRequested(LogoutRequested event, Emitter<AuthState> emit) async {
    emit(AuthInitial());
  }
}
