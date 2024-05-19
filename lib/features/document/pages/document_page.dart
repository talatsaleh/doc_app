import 'package:doc_edit_flutter/core/navigation/routes.dart';
import 'package:doc_edit_flutter/features/document/state/document_controller.dart';
import 'package:doc_edit_flutter/features/document/widgets/menu_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

final _quillControllerProvider =
    Provider.family<QuillController?, String>((ref, id) {
  final test = ref.watch(DocumentController.provider(id));
  return test.quillController;
});

class DocumentPage extends ConsumerWidget {
  const DocumentPage({
    super.key,
    required this.documentId,
  });

  final String documentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          NewMenuBar(
            newDocumentPressed: () {
              Routemaster.of(context).push(AppRoutes.newDocument);
            },
          ),
          _ToolBar(
            documentId: documentId,
          ),
          Expanded(
            child: _DocumentEditorWidget(
              documentId: documentId,
            ),
          ),
        ],
      ),
    );
  }
}

class _DocumentEditorWidget extends ConsumerStatefulWidget {
  const _DocumentEditorWidget({super.key, required this.documentId});

  final String documentId;

  @override
  ConsumerState createState() => __DocumentEditorState();
}

class __DocumentEditorState extends ConsumerState<_DocumentEditorWidget> {
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final quillController =
        ref.watch(_quillControllerProvider(widget.documentId));
    return GestureDetector(
      onTap: () => _focusNode.requestFocus(),
      child: KeyboardListener(
        focusNode: FocusNode(),
        onKeyEvent: (event) {
          if (event.logicalKey == LogicalKeyboardKey.control &&
                  event.character == 'b' ||
              event.logicalKey == LogicalKeyboardKey.meta) {
            if (quillController
                .getSelectionStyle()
                .attributes
                .keys
                .contains('bold')) {
              quillController
                  .formatSelection(Attribute.clone(Attribute.bold, null));
            } else {
              quillController.formatSelection(Attribute.bold);
            }
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          child: Card(
            elevation: 7,
            child: Padding(
              padding: const EdgeInsets.all(86),
              child: QuillEditor(
                focusNode: _focusNode,
                scrollController: _scrollController,
                configurations: QuillEditorConfigurations(
                    // embedBuilders: kIsWeb
                    //     ? FlutterQuillEmbeds.editorWebBuilders()
                    //     : FlutterQuillEmbeds.editorBuilders(),
                    controller: quillController!,
                    scrollable: true,
                    autoFocus: false,
                    checkBoxReadOnly: false,
                    expands: false,
                    padding: EdgeInsets.zero,
                    customStyles: DefaultStyles(
                      h1: DefaultTextBlockStyle(
                        TextStyle(
                          fontSize: 36,
                          color: Theme.of(context).colorScheme.onBackground,
                          height: 1.15,
                          fontWeight: FontWeight.w600,
                        ),
                        const VerticalSpacing(32, 28),
                        const VerticalSpacing(12, 0),
                        null,
                      ),
                      h2: DefaultTextBlockStyle(
                        TextStyle(
                          fontSize: 30,
                          color: Theme.of(context).colorScheme.onBackground,
                          fontWeight: FontWeight.w600,
                        ),
                        const VerticalSpacing(28, 24),
                        const VerticalSpacing(0, 0),
                        null,
                      ),
                      h3: DefaultTextBlockStyle(
                        TextStyle(
                          fontSize: 24,
                          color: Theme.of(context).colorScheme.onBackground,
                          fontWeight: FontWeight.w600,
                        ),
                        const VerticalSpacing(18, 14),
                        const VerticalSpacing(0, 0),
                        null,
                      ),
                      paragraph: DefaultTextBlockStyle(
                        TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.onBackground,
                          fontWeight: FontWeight.w400,
                        ),
                        const VerticalSpacing(2, 0),
                        const VerticalSpacing(0, 0),
                        null,
                      ),
                    )),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _defaultEmbedBuilderWeb(BuildContext context,
      QuillController controller, Embed node, bool readOnly) {
    throw UnimplementedError(
      'Embeddable type "${node.value.type}" is not supported by default '
      'embed builder of QuillEditor. You must pass your own builder function '
      'to embedBuilder property of QuillEditor or QuillField widgets.',
    );
  }
}

class _ToolBar extends ConsumerWidget {
  const _ToolBar({super.key, required this.documentId});

  final String documentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quillController = ref.watch(_quillControllerProvider(documentId));
    if (quillController == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return QuillToolbar.simple(
        configurations: QuillSimpleToolbarConfigurations(
      // embedButtons: FlutterQuillEmbeds.toolbarButtons(),
      controller: quillController,
      multiRowsDisplay: false,
      showAlignmentButtons: true,
    ));
  }
}
