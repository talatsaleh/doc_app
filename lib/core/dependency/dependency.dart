import 'package:appwrite/appwrite.dart';
import 'package:doc_edit_flutter/core/constants/constants.dart';
import 'package:doc_edit_flutter/core/reporsitory/repository_database.dart';
import 'package:doc_edit_flutter/core/state/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../reporsitory/reporsitory_auth.dart';

abstract class Dependency {
  static Provider<Client> get client => _clientProvider;

  static Provider<Databases> get database => _databaseProvider;

  static Provider<Account> get account => _accountProvider;

  static Provider<Realtime> get realtime => _realtimeProvider;
}
abstract class Repository {
  static Provider<AuthRepository> get auth => AuthRepository.provider;
  static Provider<DatabaseRepository> get database => DatabaseRepository.provider;
}
abstract class AppState {
  static StateNotifierProvider<AuthService,AuthState> get auth => AuthService.provider;
}

final _clientProvider = Provider<Client>((ref) => Client()
  ..setEndpoint(appwriteEndPoint)
  ..setSelfSigned(status: true)
  ..setProject(appwriteProjectId));

final _databaseProvider =
    Provider<Databases>((ref) => Databases(ref.read(_clientProvider)));

final _accountProvider = Provider((ref) => Account(ref.read(_clientProvider)));

final _realtimeProvider =
    Provider((ref) => Realtime(ref.read(_clientProvider)));

