import 'package:bloc/bloc.dart';
import 'package:intern_app/app/repository/auth_repository.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authenticationRepository) : super(LoginInitial());
  final AuthenticationRepository _authenticationRepository;

  Future<void> logInWithGoogle() async {
    emit(Loging());
    try {
      await _authenticationRepository.logInWithGoogle();
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailed(e.toString()));
    }
  }
}
