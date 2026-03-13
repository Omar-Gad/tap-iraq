import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;

  AuthCubit({
    required LoginUseCase loginUseCase,
    required RegisterUseCase registerUseCase,
  })  : _loginUseCase = loginUseCase,
        _registerUseCase = registerUseCase,
        super(AuthInitial());

  Future<void> login(String login, String password) async {
    emit(AuthLoading());
    try {
      final user = await _loginUseCase.execute(
        LoginParams(login: login, password: password),
      );
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> register(String name, String login, String password) async {
    emit(AuthLoading());
    try {
      final user = await _registerUseCase.execute(
        RegisterParams(name: name, login: login, password: password),
      );
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
