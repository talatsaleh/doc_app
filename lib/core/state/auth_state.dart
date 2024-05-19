import 'package:appwrite/models.dart';
import 'package:doc_edit_flutter/core/dependency/dependency.dart';
import 'package:doc_edit_flutter/core/exception/repo_exception.dart';
import 'package:doc_edit_flutter/core/models/app_error.dart';
import 'package:doc_edit_flutter/core/utils/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_notifier/state_notifier.dart';

import 'base_state.dart';

final _authServiceProvider =
StateNotifierProvider<AuthService, AuthState>((ref) => AuthService(ref));

class AuthService extends StateNotifier<AuthState> {
  final Ref _ref;

  AuthService(this._ref)
      : super(const AuthState.unAuthenticated(isLoading: true)) {
    refresh();
  }

  static StateNotifierProvider<AuthService, AuthState> get provider =>
      _authServiceProvider;

  Future<void> refresh() async {
    try {
      final user = await _ref.read(Repository.auth).get();
      setUser(user);
    } on RepositoryException catch (_){
      logger.info('Not authenticated');
      state = const AuthState.unAuthenticated();
    }
  }
  void setUser(User user){
    logger.info('Authentication successful, setting $user');
    state = state.copyWith(user: user,isLoading: false);
  }
  Future<void> signOut() async {
    try{
        await _ref.read(Repository.auth).deleteSession(sessionId: 'current');
        logger.info('Sign out successful');
        state = const AuthState.unAuthenticated();
    } on RepositoryException catch (e){
      state = state.copyWith(error: AppError(message: e.message));
    }
  }
}

class AuthState extends StateBase {
  final User? user;
  final bool isLoading;

  const AuthState({
    this.user,
    this.isLoading = false,
    AppError? error,
  }) : super(error);

  const AuthState.unAuthenticated({this.isLoading = false})
      : user = null,
        super(null);

  @override
  List<Object?> get props => [user, isLoading, error];

  bool get isAuthenticated => user != null;

  AuthState copyWith({
    User? user,
    bool? isLoading,
    AppError? error,
  }) =>
      AuthState(
          user: user ?? this.user,
          error: error ?? this.error,
          isLoading: isLoading ?? this.isLoading);
}
