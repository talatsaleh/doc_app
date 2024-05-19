import 'dart:async';

import 'package:doc_edit_flutter/core/dependency/dependency.dart';
import 'package:doc_edit_flutter/features/document/state/doucment_state.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final _documentProvider =
    StateNotifierProvider.family<DocumentController, DocumentState, String>(
  (ref, documentId) => DocumentController(
    ref,
    documentId: documentId,
  ),
);

class DocumentController extends StateNotifier<DocumentState> {
  // final _deviceId = const Uuid().v4();

  // Timer? _debounce;
  final Ref _ref;

  DocumentController(this._ref, {required String documentId})
      : super(DocumentState(id: documentId)) {
    _setUpDocument();
  }

  // late final StreamSubscription<dynamic> documentListener;
  // late final StreamSubscription<dynamic> realTimeListener;

  static StateNotifierProviderFamily<DocumentController, DocumentState, String>
      get provider => _documentProvider;

  static AlwaysAliveRefreshable<DocumentController> notifier(
          String documentId) =>
      provider(documentId).notifier;

  Future<void> _setUpDocument() async {
    final quillDoc = Document()..insert(0, '');

    final controller = QuillController(
      document: quillDoc,
      selection: const TextSelection.collapsed(
        offset: 0,
      ),
    );
    state = state.copyWith(
      quillDocument: quillDoc,
      quillController: controller,
    );
  }
}
