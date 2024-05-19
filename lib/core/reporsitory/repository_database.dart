import 'package:appwrite/appwrite.dart';
import 'package:doc_edit_flutter/core/constants/constants.dart';
import 'package:doc_edit_flutter/core/dependency/dependency.dart';
import 'package:doc_edit_flutter/core/exception/repo_exception.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _databaseRepositoryProvider = Provider<DatabaseRepository>((ref) {
  return DatabaseRepository(ref);
});

class DatabaseRepository with RepositoryExceptionMixin {
  DatabaseRepository(this._ref);

  final Ref _ref;

  static Provider<DatabaseRepository> get provider =>
      _databaseRepositoryProvider;

  Databases get _database => _ref.read(Dependency.database);

  Future<void> createNewPage({
    required String documentId,
    required String owner,
  }) async {
    Future.wait([
      _database.createDocument(
          databaseId: CollectionNames.databaseId,
          collectionId: CollectionNames.pages,
          documentId: documentId,
          data: {
            'owner': owner,
            'title': null,
            'content': null,
          }),
      _database.createDocument(
          databaseId: CollectionNames.databaseId,
          collectionId: CollectionNames.delta,
          documentId: documentId,
          data: {
            'delta': null,
            'deviceid': null,
            'user': null,
          })
    ]);
  }
}
