import 'dart:async';

import 'package:appwrite/appwrite.dart';
import 'package:doc_edit_flutter/core/utils/logger.dart';

class RepositoryException implements Exception {
  const RepositoryException(this.message, [this.exception, this.stackTrace]) ;

  final String message;
  final Exception? exception;
  final StackTrace? stackTrace;

  @override
  String toString() {
    return 'RepositoryException: $message';
  }
}
mixin RepositoryExceptionMixin {
  Future<T> exceptionHandler<T>(
    FutureOr computation, {
    String unkownMessage = 'Repository Exception',
  }) async {
    try {
      return await computation;
    } on AppwriteException catch (e) {
      logger.warning(e.message, e);
      throw RepositoryException(e.message ?? 'An undefined error occurred');
    } on Exception catch (e,st){
      logger.severe(unkownMessage,e,st);
      throw RepositoryException(unkownMessage,e,st);
    }
  }
}
