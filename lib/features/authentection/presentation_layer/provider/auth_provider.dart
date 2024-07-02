import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/contantsVarApp.dart';
import '../../../../injection_container.dart';
import '../../domain_layer/usecases/login.dart';
import '../../domain_layer/usecases/logout.dart';
import '../../domain_layer/usecases/register.dart';

final Auth = StateNotifierProvider<AuthNotifier,AsyncValue<bool>>((ref) {
  return AuthNotifier(sl(),sl(),sl());
});

class AuthNotifier extends StateNotifier<AsyncValue<bool>> {
  final RegisterUseCase _registerUseCase;
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;
  AuthNotifier(this._registerUseCase, this._loginUseCase, this._logoutUseCase) : super(AsyncValue.data(false));

  Future<bool> register(userModel) async {
    state=AsyncValue.loading();
    await _registerUseCase.call(userModel);
    state =  AsyncValue.data(false);
    return true;
  }


  Future<bool> login(userModel) async {
    state=AsyncValue.loading();
    await _loginUseCase.call(userModel);
    state =  AsyncValue.data(false);
    return true;
  }


  Future<bool> logout() async {
    state=AsyncValue.loading();
    await _logoutUseCase.call("logout");
    state =  AsyncValue.data(false);
    return true;
  }

}
