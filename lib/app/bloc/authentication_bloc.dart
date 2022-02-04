import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intern_app/app/repository/auth_repository.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(
      {required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(authenticationRepository.currentUser != null
            ? AuthenticationState.authenticated(
                authenticationRepository.currentUser!)
            : const AuthenticationState.unauthenticated()) {
    on<AuthenticationUserChanged>(_onUserChanged);
    on<AuthenticationLogoutRequested>(_onLogoutRequested);
    _userSubscription = _authenticationRepository.user
        .listen((event) => add(AuthenticationUserChanged(event)));
  }
  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<User?> _userSubscription;

  void _onUserChanged(
      AuthenticationUserChanged event, Emitter<AuthenticationState> emit) {
    emit(event.user != null
        ? AuthenticationState.authenticated(event.user!)
        : const AuthenticationState.unauthenticated());
  }

  void _onLogoutRequested(AuthenticationLogoutRequested event,
      Emitter<AuthenticationState> emit) async {
    _authenticationRepository.logOut();
    emit(const AuthenticationState.unauthenticated());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
