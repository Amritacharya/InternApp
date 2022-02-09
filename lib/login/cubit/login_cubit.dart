import 'package:bloc/bloc.dart';
import 'package:intern_app/app/repository/auth_repository.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authenticationRepository) : super(LoginState.initial());
  final AuthenticationRepository _authenticationRepository;

  Future<void> logInWithGoogle() async {
    emit(LoginState.loading());
    try {
      await _authenticationRepository.logInWithGoogle();
      emit(LoginState.success());
    } catch (e) {
      emit(LoginState.failed(e.toString()));
    }
  }
}
