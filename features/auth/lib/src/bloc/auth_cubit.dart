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
        super(const AuthInitial());

  void switchStep(AuthStep step) {
    emit(AuthInitial(
      step: step,
      email: state.email,
      password: state.password,
    ));
  }

  void saveCredentials(String email, String password) {
    emit(AuthInitial(
      step: AuthStep.userRegister,
      email: email,
      password: password,
    ));
  }

  Future<void> login(String email, String password) async {
    final currentStep = state.step;
    emit(AuthLoading(step: currentStep));
    try {
      final user = await _loginUseCase.execute(
        LoginParams(login: email, password: password),
      );
      emit(AuthSuccess(user, step: currentStep));
    } catch (e) {
      emit(AuthError(e.toString(), step: currentStep));
    }
  }

  Future<void> registerFinal({required String name, required String phone}) async {
    final email = state.email;
    final password = state.password;

    if (email == null || password == null) {
      emit(const AuthError('Missing registration data'));
      return;
    }

    emit(AuthLoading(
      step: state.step,
      email: email,
      password: password,
    ));

    try {
      final user = await _registerUseCase.execute(
        RegisterParams(
          name: name,
          login: email,
          password: password,
          phone: phone,
        ),
      );

      emit(AuthSuccess(
        user,
        step: state.step,
        email: email,
        password: password,
      ));
    } catch (e) {
      emit(AuthError(
        e.toString(),
        step: state.step,
        email: email,
        password: password,
      ));
    }
  }

}

