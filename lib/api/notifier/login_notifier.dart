import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/login_response.dart';
import '../services/api_service.dart';

/*final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AsyncValue<LoginResponse>>(
        (ref) => AuthNotifier(ref.read(apiProvider)));

class AuthNotifier extends StateNotifier<AsyncValue<LoginResponse>> {
  AuthNotifier(this.service) : super(AsyncData(LoginResponse()));

  final ApiService service;

  void login(String email, String password) async {
    state = const AsyncLoading();

    LoginRequestModel requestModel =
        LoginRequestModel(email: email, password: password);
    state = await service.login(requestModel);
  }
}*/

final loginNotifierProvider = StateNotifierProvider<LoginNotifier, LoginData>(
    (ref) => LoginNotifier(ref.read(apiProvider)));

class LoginNotifier extends StateNotifier<LoginData> {
  LoginNotifier(this.service)
      : super(LoginData(LoginStatus.initialize, LoginResponse()));

  final ApiService service;

  void login(String email, String password) async {
    state = LoginData(LoginStatus.loading, LoginResponse());

    LoginRequestModel requestModel =
        LoginRequestModel(email: email, password: password);
    state = await service.login(requestModel);
  }
}

class LoginData {
  LoginStatus status;
  LoginResponse response;

  LoginData(this.status, this.response);
}

enum LoginStatus { initialize, loading, success, failed }

/*class AuthNotifier extends StateNotifier<AsyncValue<LoginResponse>> {
  AuthNotifier(this.ref) : super(AsyncData(LoginResponse()));
  final StateNotifierProviderRef ref;

  Future<void> login(String email, String password) async {
    LoginRequestModel requestModel =
        LoginRequestModel(email: email, password: password);

    state = const AsyncValue.loading();
    try {
      final response = await ref.read(apiProvider).login(requestModel);
      debugPrint('AuthNotifier token: ${response.token}');
      state = AsyncValue.data(response);
    } catch (e) {
      debugPrint('AuthNotifier error: ${e.toString()}');
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }
}*/
