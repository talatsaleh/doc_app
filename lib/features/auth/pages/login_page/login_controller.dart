import 'package:doc_edit_flutter/core/controller_State_Base.dart';
import 'package:doc_edit_flutter/core/dependency/dependency.dart';
import 'package:doc_edit_flutter/core/exception/repo_exception.dart';
import 'package:doc_edit_flutter/core/models/app_error.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final _loginControllerProvider =
    StateNotifierProvider<LoginController, ControllerStateBase>(
        (ref) => LoginController(ref));

class LoginController extends StateNotifier<ControllerStateBase> {
  LoginController(this._ref) : super(const ControllerStateBase());

  final Ref _ref;

  static StateNotifierProvider<LoginController, ControllerStateBase>
      get provider => _loginControllerProvider;

  static AlwaysAliveRefreshable<LoginController> get notifier =>
      provider.notifier;

  Future<void> createSession(
      {required String email, required String password}) async {
    try {
      await _ref
          .read(Repository.auth)
          .createSession(email: email, password: password);

      final user = await _ref.read(Repository.auth).get();
      _ref.read(AppState.auth.notifier).setUser(user);
    } on RepositoryException catch (e) {
      state = state.copyWith(error: AppError(message: e.message));
    }
  }
}
