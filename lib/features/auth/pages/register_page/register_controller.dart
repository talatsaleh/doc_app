import 'package:doc_edit_flutter/core/controller_State_Base.dart';
import 'package:doc_edit_flutter/core/dependency/dependency.dart';
import 'package:doc_edit_flutter/core/exception/repo_exception.dart';
import 'package:doc_edit_flutter/core/models/app_error.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

StateNotifierProvider<RegisterController, ControllerStateBase>
    _registerController =
    StateNotifierProvider((ref) => RegisterController(ref));

class RegisterController extends StateNotifier<ControllerStateBase> {
  RegisterController(this._ref) : super(const ControllerStateBase());

  final Ref _ref;

  static StateNotifierProvider<RegisterController, ControllerStateBase>
      get provider => _registerController;

  static AlwaysAliveRefreshable<RegisterController> get notifier =>
      provider.notifier;

  Future<void> create(
      {required String email,
      required String password,
      required String name}) async {
    try {
      final user = await _ref
          .read(Repository.auth)
          .create(email: email, password: password, name: name);
      await _ref
          .read(Repository.auth)
          .createSession(email: email, password: password);
      print('sucess register');
      _ref.read(AppState.auth.notifier).setUser(user);
    } on RepositoryException catch (e) {
      state = state.copyWith(error: AppError(message: e.message));
    }
  }
}
