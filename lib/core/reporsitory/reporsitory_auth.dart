
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:doc_edit_flutter/core/dependency/dependency.dart';
import 'package:doc_edit_flutter/core/exception/repo_exception.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _authRepoProvider =
    Provider<AuthRepository>((ref) => AuthRepository(ref));

class AuthRepository with RepositoryExceptionMixin {
  const AuthRepository(this._ref);

  final Ref _ref;

  static Provider<AuthRepository> get provider => _authRepoProvider;

  Account get _account => _ref.read(Dependency.account);

  Future<User> create({
    required String email,
    required String password,
    required String name,
  }) {
    return exceptionHandler(_account.create(
      userId: ID.unique(),
      email: email,
      password: password,
      name: name,
    ));
  }

  Future<Session> createSession({
    required String email,
    required String password,
  }) {
      return exceptionHandler<Session>(_account.createEmailPasswordSession(
      email: email,
      password: password,
    ));
  }

  Future<User> get() {
    return exceptionHandler(_account.get());
  }

  Future<void> deleteSession({
    required String sessionId,
  }) {
    return exceptionHandler(_account.deleteSession(sessionId: sessionId));
  }
}
