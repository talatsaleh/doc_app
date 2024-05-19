import 'package:doc_edit_flutter/core/controller_State_Base.dart';
import 'package:doc_edit_flutter/core/models/app_error.dart';
import 'package:doc_edit_flutter/core/models/document_page_data.dart';
import 'package:flutter_quill/flutter_quill.dart';

class DocumentState extends ControllerStateBase {
  const DocumentState(
      {required this.id,
      this.documentPageData,
      this.quillDocument,
      this.quillController,
      this.isSavedRemotely = false,
      super.error});

  final String id;
  final DocumentPageData? documentPageData;
  final Document? quillDocument;
  final QuillController? quillController;
  final bool isSavedRemotely;

  @override
  List<Object?> get props => [id, error];

  @override
  DocumentState copyWith({
    String? id,
    DocumentPageData? documentPageData,
    Document? quillDocument,
    QuillController? quillController,
    bool? isSavedRemotely,
    AppError? error,
  }) {
    return DocumentState(
      id: id ?? this.id,
      error: error ?? this.error,
      documentPageData: documentPageData ?? this.documentPageData,
      quillController: quillController ?? this.quillController,
      quillDocument: quillDocument ?? this.quillDocument,
      isSavedRemotely: isSavedRemotely ?? this.isSavedRemotely,
    );
  }
}
